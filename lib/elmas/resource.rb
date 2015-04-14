require File.expand_path('../utils', __FILE__)

module Elmas
  module Resource
    attr_accessor :attributes
    attr_accessor :id
    attr_accessor :href

    def initialize(attributes = {})
      @attributes = attributes
    end

    def id
      (attributes[:id] ||= nil)
    end

    def id=(value)
      attributes[:id] = value
    end

    def url
      if id
        "#{Utils.collection_path self.class.name}/#{id}"
      else
        Utils.collection_path self.class.name
      end
    end

    def find
      begin
        @response = Elmas.get(url)
      end
    end

    def save
      attributes_to_submit = self.sanitize
      begin
        @response = Elmas.post(url, attributes_to_submit)
      rescue
        #log error somehow
      end

      response
    end

    def sanitize
      to_submit = {}
      @attributes.each do |key, value|
        if value.is_a? Elmas::Resource #Turn relation into ID
          to_submit["#{key}_#{id}"] = value.id
        else
          to_submit[key] = value
        end
      end
      to_submit
    end

    def response
      @response
    end
  end
end
