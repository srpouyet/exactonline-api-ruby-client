module Elmas
  class Parser
    def initialize(json)
      @object = JSON.parse(json)
    end

    def results
      @object["d"]["results"]
    end

    def first_result
      results[0]
    end
  end
end
