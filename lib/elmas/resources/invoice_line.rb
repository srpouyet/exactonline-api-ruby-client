module Elmas
  class InvoiceLine
    include Elmas::Resource

    def url
      "salesinvoice/SalesInvoiceLines"
    end

    def mandatory_attributes
      [:invoice_id, :item]
    end
  end
end
