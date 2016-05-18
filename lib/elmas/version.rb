module Elmas
  class Version
    MAJOR = 2
    MINOR = 2
    PATCH = 1

    class << self
      def to_s
        [MAJOR, MINOR, PATCH].compact.join(".")
      end
    end
  end
end
