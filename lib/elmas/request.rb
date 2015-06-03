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

    def parse_path(path, options)
      path = "#{division}/#{path}" unless options[:no_division]
      path = endpoint + path unless options[:no_endpoint]
      path
    end

    def add_headers
      headers = {}
      headers["Content-Type"] = "application/#{response_format}"
      headers["Accept"] = "application/#{response_format}"
      headers["User-Agent"] = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"
      headers["Authorization"] = "Bearer #{access_token}" if access_token
      headers
    end

    # Perform an HTTP request
    def request(method, path, options = {})
      path = parse_path(path, options)
      connection = setup_connection(options[:url])

      response = connection.send(method) do |request|
        case method
        when :post
          request.url path
          request.body = options[:params].to_json
        when :get
          request.url path
        end
        request.headers = add_headers
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
