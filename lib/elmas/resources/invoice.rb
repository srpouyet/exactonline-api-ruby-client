module Elmas
  class Invoice
    include Elmas::Resource

    def url
      "salesinvoice/SalesInvoices"
    end
  end
end
