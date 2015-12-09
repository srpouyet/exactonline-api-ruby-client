require 'spec_helper'

describe Elmas::AgingReceivablesList do
  it "can initialize" do
    sales_invoice = Elmas::AgingReceivablesList.new
    expect(sales_invoice).to be_a(Elmas::AgingReceivablesList)
  end

  it "is valid without attributes" do
    sales_invoice = Elmas::AgingReceivablesList.new
    expect(sales_invoice.valid?).to eq(true)
  end

  it "is valid with attributes" do
    sales_invoice = Elmas::AgingReceivablesList.new(invoice_ID: "abc-def")
    expect(sales_invoice.valid?).to eq(true)
  end

  context "Applying filters" do
    resource = Elmas::AgingReceivablesList.new(id: 123)
    it "should apply ID filter for find" do
      expect(Elmas).to receive(:get).with("financial/AgingReceivablesLists(guid'123')?")
      resource.find
    end

    it "should apply no filters for find_all" do
      resource = Elmas::AgingReceivablesList.new(type: 2)
      expect(Elmas).to receive(:get).with("financial/AgingReceivablesLists?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Elmas::AgingReceivablesList.new(id: "23", type: "2")
      expect(Elmas).to receive(:get).with("financial/AgingReceivablesLists?$filter=Type+eq+'2'&$filter=ID+eq+guid'23'")
      resource.find_by(filters: [:type, :id])
    end
  end
end
