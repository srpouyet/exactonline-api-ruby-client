require 'faraday_middleware'

module Elmas
  # @private
  module Connection
    private

    def connection(connection_options={})
      options = {
        headers: {'Accept' => "application/#{response_format}; charset=utf-8", 'User-Agent' => user_agent},
        url: "#{base_url}",
      }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        # connection.use FaradayMiddleware::OAuth2, client_id, access_token
        connection.use Faraday::Request::UrlEncoded
        case response_format.to_s.downcase
        when 'json' then connection.use Faraday::Response::ParseJson
        end
        connection.adapter(adapter)
      end
    end
  end
end
