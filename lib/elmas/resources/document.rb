module Elmas
  class Document
    include Elmas::Resource

    def valid_actions
      [:get]
    end

    def base_path
      "read/crm/Documents"
    end

    def other_attributes
      [:account]
    end

    def mandatory_attributes
      []
    end
  end
end
