module Elmas
  class Version
    MAJOR = 0
    MINOR = 1
    PATCH = 2

    class << self
      def to_s
        [MAJOR, MINOR, PATCH].compact.join(".")
      end
    end
  end
end
