require File.expand_path("../utils", __FILE__)
require File.expand_path("../exception", __FILE__)
require File.expand_path("../uri", __FILE__)
require File.expand_path("../sanitizer", __FILE__)

module Elmas
  module Resource
    include UriMethods
    include Sanitizer

    attr_accessor :attributes, :url
    attr_reader :response

    def initialize(attributes = {}, client: nil)
      @attributes = Utils.normalize_hash(attributes)
      @filters = []
      @query = []
      @client = client
    end

    def id
      @attributes[:id]
    end

    def find_all(options = {})
      @order_by = options[:order_by]
      @select = options[:select]
      response = get(uri([:order, :select]))
      response.results if response
    end

    # Pass filters in an array, for example 'filters: [:id, :name]'
    def find_by(options = {})
      @filters = options[:filters]
      @order_by = options[:order_by]
      @select = options[:select]
      response = get(uri([:order, :select, :filters]))
      response.results if response
    end

    def find
      return nil unless id?
      response = get(uri([:id]))
      response.results.first if response
    end

    # Normally use the url method (which applies the filters) but sometimes you only want to use the base path or other paths
    def get(uri = self.uri)
      @response = client.get(URI.unescape(uri.to_s))
    end

    def valid?
      mandatory_attributes.all? do |attribute|
        @attributes.key? attribute
      end
    end

    def id?
      !@attributes[:id].nil?
    end

    def save
      attributes_to_submit = sanitize
      if valid?
        return @response = client.post(base_path, params: attributes_to_submit) unless id?
        return @response = client.put(basic_identifier_uri, params: attributes_to_submit)
      else
        Elmas.error("Invalid Resource #{self.class.name}, attributes: #{@attributes.inspect}")
        Elmas::Response.new(Faraday::Response.new(status: 400, body: "Invalid Request"))
      end
    end

    def delete
      return nil unless id?
      client.delete(basic_identifier_uri)
    end

    # Getter/Setter for resource
    def method_missing(method, *args, &block)
      yield if block
      if /^(\w+)=$/ =~ method
        set_attribute($1, args[0])
      else
        nil unless @attributes[method.to_sym]
      end
      @attributes[method.to_sym]
    end

    def client
      @client || Elmas
    end

    private

    def set_attribute(attribute, value)
      @attributes[attribute.to_sym] = value if valid_attribute?(attribute)
    end

    def valid_attribute?(attribute)
      valid_attributes.include?(attribute.to_sym)
    end

    def valid_attributes
      @valid_attributes ||= mandatory_attributes.inject(other_attributes, :<<)
    end
  end
end
