require 'pry'

module Elmas
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={})
      request(:get, path, options)
    end

    # Perform an HTTP POST request
    def post(path, options={})
      request(:post, path, options)
    end

    # Perform an HTTP PUT request
    def put(path, options={})
      request(:put, path, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={})
      request(:delete, path, options)
    end

    private

    # Perform an HTTP request
    def request(method, path, options={})
      url = options[:url] || default_url
      connection = setup_connection(url)
      connection.send(method) do |request|
        case method
        when :post
          request.url path
          request.body = options[:params]
        when :get
          request.url path
        end
      end
    end

    def default_url
      "#{base_url}/#{endpoint}"
    end

    def setup_connection(url)
      Faraday.new(url: url) do |faraday|
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
