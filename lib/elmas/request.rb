require 'pry'
require "faraday/detailed_logger"
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
      unless options[:no_division]
        path = "#{division}/#{path}"
      end

      unless options[:no_endpoint]
        path = endpoint + path
      end

      connection = setup_connection(options[:url])
      response = connection.send(method) do |request|
        case method
        when :post
          request.url path
          request.body = options[:params].to_json
        when :get
          request.url path
        end
        request.headers['Content-Type'] = "application/#{response_format}"
        request.headers['Accept'] = "application/#{response_format}"
        request.headers['User-Agent'] = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
        if access_token
          request.headers['Authorization'] = access_token
        end
      end
      Response.new(response)
    end

    def setup_connection(url)
      connection_url = url || base_url
      Faraday.new(url: connection_url) do |faraday|
        faraday.response :detailed_logger
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
