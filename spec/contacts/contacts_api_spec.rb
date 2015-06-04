require 'spec_helper'

describe Elmas::Contact do
  it "can initialize" do
    contact = Elmas::Contact.new
    expect(contact).to be_a(Elmas::Contact)
  end

  it "accepts attribute setter" do
    contact = Elmas::Contact.new
    contact.birth_name = "Karel"
    expect(contact.birth_name).to eq "Karel"
  end

  it "returns value for getters" do
    contact = Elmas::Contact.new({ "BirthName" => "Karel" })
    expect(contact.birth_name).to eq "Karel"
  end

  it "crashes and burns when getting an unset attribute" do
    contact = Elmas::Contact.new({ name: "Piet" })
    expect(contact.try(:birth_name)).to eq nil
  end

  context "Applying filters" do
    it "should apply ID filter for find" do
      resource = Elmas::Contact.new(id: "23")
      expect(URI.unescape(resource.uri([:filters]).to_s)).to eq("crm/Contacts?$filter=ID+eq+guid'23'")
    end

    it "should apply no filters for find_all" do
      resource = Elmas::Contact.new(id: "23", name: "Karel")
      expect(Elmas).to receive(:get).with("crm/Contacts?")
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Elmas::Contact.new(id: "23", name: "Karel")
      expect(Elmas).to receive(:get).with("crm/Contacts?$filter=name+eq+'Karel'&$filter=ID+eq+guid'23'")
      resource.find_by(filters: [:name, :id])
    end
  end
end
