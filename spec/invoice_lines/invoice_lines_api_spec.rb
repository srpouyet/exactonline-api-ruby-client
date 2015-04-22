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
end
