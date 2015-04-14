require 'faraday_middleware'

module Elmas
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Accept' => "application/#{response_format}; charset=utf-8", 'User-Agent' => user_agent},
        :url => endpoint,
      }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        # connection.use FaradayMiddleware::OAuth2, client_id, access_token
        connection.use Faraday::Request::UrlEncoded
        connection.use FaradayMiddleware::Mashify unless raw
        unless raw
          case format.to_s.downcase
          when 'json' then connection.use Faraday::Response::ParseJson
          end
        end
        connection.use FaradayMiddleware::RaiseHttpException
        connection.adapter(adapter)
      end
    end
  end
end
