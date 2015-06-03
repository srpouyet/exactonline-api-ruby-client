require File.expand_path('../utils', __FILE__)
require File.expand_path('../exception', __FILE__)
require 'pry'
module Elmas
  module Resource
    STANDARD_FILTERS = [:id].freeze

    attr_accessor :attribute, :id, :url
    attr_reader :response

    def initialize(attributes = {})
      @attributes = Utils.normalize_hash(attributes)
      @filters = STANDARD_FILTERS
    end

    def id
      (attributes[:id] ||= nil)
    end

    def id=(value)
      attributes[:id] = value
    end

    def base_path
      Utils.collection_path self.class.name
    end

    def url
      apply_filters(base_path)
    end

    def find_all
      find(base_path)
    end

    # Normally use the url method (which applies the filters) but sometimes you only want to use the base path or other paths
    def find(url = self.url)
      begin
        @response = Elmas.get(url)
      rescue
        puts "I dunno what went wrong"
      end
    end

    def valid?
      valid = true
      mandatory_attributes.each do |attribute|
        valid = @attributes.has_key? attribute
      end
      valid
    end

    # Pass filters in an array, for example [:id, :name]
    def find_by(filters)
      @filters = filters
      find
    end

    def save
      attributes_to_submit = self.sanitize
      if self.valid?
        begin
          @response = Elmas.post(base_path, attributes_to_submit)
        rescue
          puts "Horrible outcome, nothing works"
        end
      else
        puts "Resource is not valid, you should add some more attributes"
      end
    end

    # Parse the attributes for to post to the API
    def sanitize
      to_submit = {}
      @attributes.each do |key, value|
        if value.is_a? Elmas::Resource #Turn relation into ID
          to_submit["#{key}".to_sym] = value.id
        else
          to_submit[key] = value
        end
      end
      to_submit
    end

    #?$filter=ID eq guid'#{id}'
    def id_filter(sign)
      "#{sign}$filter=ID eq guid'#{id}'"
    end

    def base_filter(sign, attribute)
      if attribute == :id
        id_filter(sign)
      else
        "#{sign}$filter=#{attribute.to_s} eq '#{@attributes[attribute]}'"
      end
    end

    def apply_filters(path)
      @filters.each_with_index do |filter, index|
       path += base_filter(sign(index), filter)
      end
      path
    end

    def sign(index)
      index == 0 ? "?" : "&"
    end

    # Getter/Setter for resource
    def method_missing(method, *args, &block)
      if /^(\w+)=$/ =~ method
        @attributes[$1.to_sym] = args[0]
      else
        nil unless @attributes[method.to_sym]
      end
      @attributes[method.to_sym]
    end
  end
end
