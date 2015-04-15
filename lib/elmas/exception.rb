module Elmas
  class BadRequestException < Exception
    def initialize(object)
      super(message)
      @object = object
    end

    def message
      case @object
      when 500
        "Server error"
      else
        "Something went wrong"
      end
    end
  end

  class UnauthorizedException < Exception

  end
end
