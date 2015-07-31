require "logger"

module Elmas
  module Log
    def logger
      dir = File.dirname("./tmp/errors.log")
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
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
