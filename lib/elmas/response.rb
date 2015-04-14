module Elmas
  module Response
    attr_accessor :status_code, :body
    def self.create(response)
      @body = response.body
      @status_code = response.status_code
    end

    def success?
      SUCCESS_CODES.include? status_code
    end

    def fail?
      ERROR_CODES.include? status_code
    end

    def unauthorized?
      UNAUTHORIZED_CODES.include? status_code
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
