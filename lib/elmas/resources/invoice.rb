module Elmas
  class Invoice
    # An invoice usually has multiple invoice lines
    # It should also have a journal id and a contact id who ordered it
    include Elmas::Resource

    def base_path
      "salesinvoice/SalesInvoices"
    end

    def mandatory_attributes
      [:journal, :ordered_by]
    end
  end
end
