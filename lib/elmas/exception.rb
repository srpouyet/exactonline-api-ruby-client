module Elmas
  class BadRequestException < Exception
    def initialize(response, parsed)
      @response = response
      @parsed = parsed
      super(message)
    end

    def message
      "code #{@response.status}: #{@parsed.error_message}"
    end
  end

  class UnauthorizedException < Exception; end
end
