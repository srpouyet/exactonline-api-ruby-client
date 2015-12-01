module Elmas
  class Version
    MAJOR = 1
    MINOR = 0
    PATCH = 0

    class << self
      def to_s
        [MAJOR, MINOR, PATCH].compact.join(".")
      end
    end
  end
end
