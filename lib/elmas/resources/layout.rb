module Elmas
  class Layout
    include Elmas::Resource

    def base_path
      "salesinvoice/Layouts"
    end

    def mandatory_attributes
      []
    end

    def other_attributes
      [
        :id, :created, :creator, :creator_full_name, :division,
        :modified, :modifier, :modifier_full_name, :subject, :type
      ]
    end
  end
end
