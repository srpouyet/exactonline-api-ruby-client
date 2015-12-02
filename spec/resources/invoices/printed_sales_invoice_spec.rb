require 'spec_helper'

describe Elmas::PrintedSalesInvoice do
  it "can initialize" do
    sales_invoice = Elmas::PrintedSalesInvoice.new
    expect(sales_invoice).to be_a(Elmas::PrintedSalesInvoice)
  end

  it "is in valid without attributes" do
    sales_invoice = Elmas::PrintedSalesInvoice.new
    expect(sales_invoice.valid?).to eq(false)
  end

  it "is valid with attributes" do
    sales_invoice = Elmas::PrintedSalesInvoice.new(invoice_ID: "abc-def")
    expect(sales_invoice.valid?).to eq(true)
  end

  context "Applying filters" do
    resource = Elmas::PrintedSalesInvoice.new(id: 123)
    it "should apply ID filter for find" do
      expect(Elmas).to receive(:get).with("salesinvoice/PrintedSalesInvoices(guid'123')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Elmas::PrintedSalesInvoice.new(type: 2)
      expect(Elmas).to receive(:get).with("salesinvoice/PrintedSalesInvoices?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Elmas::PrintedSalesInvoice.new(id: "23", type: "2")
      expect(Elmas).to receive(:get).with("salesinvoice/PrintedSalesInvoices?$filter=Type+eq+'2'&$filter=ID+eq+guid'23'")
      resource.find_by(filters: [:type, :id])
    end
  end
end
