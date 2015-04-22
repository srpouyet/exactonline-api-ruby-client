module Elmas
  class InvoiceLine
    # An invoice_line should always have a reference to an item and to an invoice.
    include Elmas::Resource

    def url
      "salesinvoice/SalesInvoiceLines"
    end

    def mandatory_attributes
      [:invoice_id, :item]
    end
  end
end
