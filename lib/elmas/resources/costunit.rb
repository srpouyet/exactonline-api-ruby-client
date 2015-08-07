module Elmas
  class Costunit
    include Elmas::Resource

    def base_path
      "hrm/Costunits"
    end

    def mandatory_attributes
      [:code, :description]
    end

    def other_attributes
      []
    end
  end
end
