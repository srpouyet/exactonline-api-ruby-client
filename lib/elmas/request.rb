require "pry"
require "faraday/detailed_logger"
module Elmas
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options = {})
      request(:get, path, options)
    end

    # Perform an HTTP POST request
    def post(path, options = {})
      request(:post, path, options)
    end

    # Perform an HTTP PUT request
    def put(path, options = {})
      request(:put, path, options)
    end

    # Perform an HTTP DELETE request
    def delete(path, options = {})
      request(:delete, path, options)
    end

    private

    def build_path(path, options)
      path = "#{division}/#{path}" unless options[:no_division]
      path = "#{endpoint}/#{path}" unless options[:no_endpoint]
      path = "#{options[:url] || base_url}/#{path}"
      path
    end

    def add_headers
      headers = {}
      headers["Content-Type"] = "application/#{response_format}"
      headers["Accept"] = "application/#{response_format}"
      headers["Authorization"] = "Bearer #{access_token}" if access_token
      headers
    end

    # Perform an HTTP request
    def request(method, path, options = {})
      path = build_path(path, options)

      response = connection.send(method) do |request|
        case method
        when :post, :put
          request.url path
          request.body = options[:params].to_json
        when :get, :delete
          request.url path
        end
        request.headers = add_headers
      end
      Response.new(response)
    end
  end
end
