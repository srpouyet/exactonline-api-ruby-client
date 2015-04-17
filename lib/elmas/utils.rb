module Elmas
  module Utils
    def self.demodulize(class_name_in_module)
      class_name_in_module.to_s.sub(/^.*::/, '')
    end

    def self.pluralize(word)
      word.to_s.sub(/([^s])$/, '\1s')
    end

    def self.collection_path(class_name)
      Utils.pluralize Utils.demodulize class_name
    end

    def self.build_url(url = nil, extra_params = nil)
      uri = url

      query_values = params.dup.merge_query(uri.query, options.params_encoder)
      query_values.update extra_params if extra_params
      uri.query = query_values.empty? ? nil : query_values.to_query(options.params_encoder)

      uri
    end
  end
end
