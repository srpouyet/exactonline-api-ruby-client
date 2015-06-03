require 'spec_helper'

describe Elmas::InvoiceLine do
  it "can initialize" do
    invoice_line = Elmas::InvoiceLine.new
    expect(invoice_line).to be_a(Elmas::InvoiceLine)
  end

  it "is not valid without certain attributes" do
    invoice_line = Elmas::InvoiceLine.new
    expect(invoice_line.valid?).to eq(false)
  end

  it "is valid with certain attributes" do
    invoice_line = Elmas::InvoiceLine.new(invoice_id:"627362", item: "23873")
    expect(invoice_line.valid?).to eq(true)
  end

  context "Applying filters" do
    it "should apply ID filter for find" do
      resource = Elmas::InvoiceLine.new(id: "23")
      expect(resource.url).to eq("salesinvoice/SalesInvoiceLines?$filter=ID eq guid'23'")
    end

    it "should apply no filters for find_all" do
      resource = Elmas::InvoiceLine.new(id: "23", item: "22")
      expect(Elmas).to receive(:get).with("salesinvoice/SalesInvoiceLines")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Elmas::InvoiceLine.new(id: "23", item: "22")
      expect(Elmas).to receive(:get).with("salesinvoice/SalesInvoiceLines?$filter=item eq '22'&$filter=ID eq guid'23'")
      resource.find_by([:item, :id])
    end
  end
end
