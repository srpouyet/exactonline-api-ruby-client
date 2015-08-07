module Elmas
  class GLAccount
    include Elmas::Resource

    def base_path
      "financial/GLAccounts"
    end

    def mandatory_attributes
      [:code, :description]
    end

    def other_attributes
      []
    end
  end
end
