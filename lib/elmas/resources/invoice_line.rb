module Elmas
  class InvoiceLine
    # An invoice_line should always have a reference to an item and to an invoice.
    include Elmas::Resource

    def base_path
      "salesinvoice/SalesInvoiceLines"
    end

    def mandatory_attributes
      [:item]
    end

    def other_attributes
      [:discount, :quantity, :amount_FC, :description, :vat_code]
    end
  end
end
