module Elmas
  class Item
    include Elmas::Resource

    def base_path
      "logistics/Items"
    end

    def other_attributes
      []
    end

    def mandatory_attributes
      [:code, :description]
    end
  end
end
