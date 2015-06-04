require 'spec_helper'

describe Elmas::Invoice do
  it "can initialize" do
    invoice = Elmas::Invoice.new
    expect(invoice).to be_a(Elmas::Invoice)
  end

  it "is not valid without certain attributes" do
    invoice = Elmas::Invoice.new
    expect(invoice.valid?).to eq(false)
  end

  it "is valid with certain attributes" do
    invoice = Elmas::Invoice.new(journal:"my-awesome-journal", ordered_by: "1230")
    expect(invoice.valid?).to eq(true)
  end

  it "sanitezes the relationships" do
    journal = "another-awesome-journal"
    id = "232878"
    invoice = Elmas::Invoice.new(journal: journal, ordered_by: Elmas::Contact.new(first_name: "Karel", last_name: "Appel", id: id))
    expect(invoice.sanitize).to eq({ journal: journal, ordered_by: id })
  end

  context "Applying filters" do
    it "should apply ID filter for find" do
      resource = Elmas::Invoice.new(id: "23")
      expect(URI.unescape(resource.uri([:filters]).to_s)).to eq("salesinvoice/SalesInvoices?$filter=ID+eq+guid'23'")
    end

    it "should apply no filters for find_all" do
      resource = Elmas::Invoice.new(id: "23", journal: "22")
      expect(Elmas).to receive(:get).with("salesinvoice/SalesInvoices?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Elmas::Invoice.new(id: "23", journal: "22")
      expect(Elmas).to receive(:get).with("salesinvoice/SalesInvoices?$filter=journal+eq+'22'&$filter=ID+eq+guid'23'")
      resource.find_by(filters: [:journal, :id])
    end
  end
end
