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
end
