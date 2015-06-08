require "logger"
module Elmas
  module Log
    def logger
      Logger.new("./tmp/errors.log", "daily")
    end

    def info(msg)
      logger.info(msg)
    end

    def error(msg)
      logger.error(msg)
    end
  end
end
