require 'spec_helper'

describe "Special Serialization" do
  it "serializes SalesEntryLine gl_account and amount_fc to GLAccount and AmountFC" do
    sales_entry_line = Elmas::SalesEntryLine.new(amount_FC: "23", entry_ID: "23299ask-2233", GL_account: "sdjkj29")
    hash = sales_entry_line.sanitize
    expect(hash).to include("AmountFC")
    expect(hash).to include("GLAccount")
    expect(hash).to include("EntryID")
  end
end
