require File.expand_path("../parser", __FILE__)
require File.expand_path("../utils", __FILE__)

module Elmas
  class Response
    attr_accessor :status_code, :body, :response

    def initialize(response)
      @response = response
    end

    def success?
      @response.success?
    end

    def body
      @response.body
    end

    def parsed
      Parser.new(body)
    end

    def results
      results = []
      if parsed.results.any?
        parsed.results.each do |attributes|
          klass = resolve_class
          results << klass.send(:new, attributes)
        end
      end
      results
    end

    def first
      results.first if results
    end

    def type
      return unless parsed.results.any?
      c_type = parsed.results.first["__metadata"]["type"]
      c_type.split(".").last
    end

    def status
      @response.status
    end

    def fail?
      ERROR_CODES.include? @response.status
    end

    def unauthorized?
      UNAUTHORIZED_CODES.include? @response.status
    end

    SUCCESS_CODES = [
      201, 202, 203, 204, 301, 302, 303, 304
    ]

    ERROR_CODES = [
      400, 401, 402, 403, 404, 500, 501, 502, 503
    ]

    UNAUTHORIZED_CODES = [
      401, 402, 403
    ]

    private

    def resolve_class
      constant_name = Utils.modulize(type)
      return Object.const_get(constant_name)
    rescue NameError
      return Class.new { include Elmas::Resource }
    end
  end
end
