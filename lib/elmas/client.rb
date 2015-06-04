require "faraday"

module Elmas
  class Client < API
    def connection
      Faraday.new do |faraday|
        # faraday.response :detailed_logger
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
