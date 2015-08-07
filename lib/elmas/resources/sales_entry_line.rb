module Elmas
  class SalesEntryLine
    # A sales entry line belongs to a sales entry
    include Elmas::Resource

    def base_path
      "salesentry/SalesEntryLines"
    end

    def mandatory_attributes
      [:amount_FC, :GL_account, :entry_ID]
    end

    def other_attributes
      [:serial_number]
    end
  end
end
