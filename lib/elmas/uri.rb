module Elmas
  module Resource
    module UriMethods
      def base_path
        Utils.collection_path self.class.name
      end

      def uri(options = {})
        options.each do |option|
          send("apply_#{option}".to_sym)
        end
        uri = URI(base_path)
        uri.query = URI.encode_www_form(@query)
        uri
      end

      # ?$filter=ID eq guid'#{id}'
      def id_filter
        ["$filter", "ID eq guid'#{id}'"]
      end

      def base_filter(attribute)
        if attribute == :id
          return id_filter
        else
          return ["$filter", "#{attribute} eq '#{@attributes[attribute]}'"]
        end
      end

      def apply_filters
        return unless @filters
        @filters.each do |filter|
          @query << base_filter(filter)
        end
      end

      def apply_order
        @query << ["$order_by", @order_by.to_s] if @order_by
      end

      def apply_select
        @query << ["$select", @select.join(",")] if @select
      end
    end
  end
end
