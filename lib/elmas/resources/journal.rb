module Elmas
  class Journal
    include Elmas::Resource

    def base_path
      "financial/Journals"
    end

    def mandatory_attributes
      []
    end

    def other_attributes
      [:code, :description]
    end
  end
end
