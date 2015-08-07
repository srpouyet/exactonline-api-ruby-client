require 'spec_helper'

describe Elmas::Document do
  it "can initialize" do
    costunit = Elmas::Document.new
    expect(costunit).to be_a(Elmas::Document)
  end

  it "accepts attribute setter" do
    costunit = Elmas::Document.new
    costunit.account = "78238"
    expect(costunit.account).to eq "78238"
  end

  it "returns value for getters" do
    costunit = Elmas::Document.new({ "Account" => "345" })
    expect(costunit.account).to eq "345"
  end

  it "crashes and burns when getting an unset attribute" do
    costunit = Elmas::Document.new({ name: "Piet" })
    expect(costunit.try(:account)).to eq nil
  end

  it "is valid without attributes" do
    costunit = Elmas::Document.new
    expect(costunit.valid?).to eq(true)
  end

  let(:resource) { resource = Elmas::Document.new(id: "23", account: "1223") }

  context "Applying filters" do
    it "should apply ID filter for find" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?$filter=ID+eq+guid'23'")
      resource.find
    end

    it "should apply no filters for find_all" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?$filter=Account+eq+'1223'&$filter=ID+eq+guid'23'")
      resource.find_by(filters: [:account, :id])
    end
  end

  context "Applying order" do
    it "should apply the order_by and filters" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?$order_by=Account&$filter=Account+eq+'1223'&$filter=ID+eq+guid'23'")
      resource.find_by(filters: [:account, :id], order_by: :account)
    end

    it "should only apply the order_by" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?$order_by=Account")
      resource.find_all(order_by: :account)
    end
  end

  context "Applying select" do
    it "should apply one select" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?$select=Account")
      resource.find_all(select: [:account])
    end

    it "should apply one select with find_by" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?$select=Account")
      resource.find_by(select: [:account])
    end

    it "should apply one select" do
      expect(Elmas).to receive(:get).with("read/crm/Documents?$select=Account,Id")
      resource.find_all(select: [:account, :id])
    end
  end
end
