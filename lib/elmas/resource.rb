require File.expand_path("../utils", __FILE__)
require File.expand_path("../exception", __FILE__)

module Elmas
  module Resource
    STANDARD_FILTERS = [:id].freeze

    attr_accessor :attribute, :url
    attr_reader :response

    def initialize(attributes = {})
      @attributes = Utils.normalize_hash(attributes)
      @filters = STANDARD_FILTERS
      @query = []
    end

    def base_path
      Utils.collection_path self.class.name
    end

    def uri(options = {})
      options.each do |option|
        self.send("apply_#{option}".to_sym)
      end
      uri = URI(base_path)
      uri.query = URI.encode_www_form(@query)
      uri
    end

    def find_all(options = {})
      @order_by = options[:order_by]
      @select = options[:select]
      get(uri([:order, :select]))
    end

    # Pass filters in an array, for example [:id, :name]
    def find_by(options = {})
      @filters = options[:filters]
      @order_by = options[:order_by]
      @select = options[:select]
      get(uri([:order, :select, :filters]))
    end

    def find(uri = self.uri)
      get(uri([:filters]))
    end

    # Normally use the url method (which applies the filters) but sometimes you only want to use the base path or other paths
    def get(uri = self.uri)
      @response = Elmas.get(URI.unescape(uri.to_s))
    end

    def valid?
      valid = true
      mandatory_attributes.each do |attribute|
        valid = @attributes.key? attribute
      end
      valid
    end

    def has_id?
      !@attributes[:id].nil?
    end

    def save
      attributes_to_submit = sanitize
      if valid?
        if has_id?
          return @response = Elmas.put(base_path, params: attributes_to_submit)
        else
          return @response = Elmas.post(base_path, params: attributes_to_submit)
        end
      else
        Elmas::Response.new
        # TODO: log "Resource is not valid, you should add some more attributes"
      end
    end

    # Parse the attributes for to post to the API
    def sanitize
      to_submit = {}
      @attributes.each do |key, value|
        if value.is_a? Elmas::Resource # Turn relation into ID
          to_submit["#{key}".to_sym] = value.id
        else
          to_submit[key] = value
        end
      end
      to_submit
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
      @filters.each_with_index do |filter, index|
        @query << base_filter(filter)
      end
    end

    def apply_order

    end

    def apply_select

    end

    def sign(index)
      index == 0 ? "?" : "&"
    end

    # Getter/Setter for resource
    def method_missing(method, *args, &block)
      yield if block
      if /^(\w+)=$/ =~ method
        @attributes[$1.to_sym] = args[0]
      else
        nil unless @attributes[method.to_sym]
      end
      @attributes[method.to_sym]
    end
  end
end
