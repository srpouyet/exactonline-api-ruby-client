require File.expand_path('../parser', __FILE__)

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
  end
end
