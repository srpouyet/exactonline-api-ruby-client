require 'spec_helper'

describe Elmas::Resource do
  context "Applying filters" do
    it "should apply ID filter for find" do
      resource = Elmas::Contact.new(id: "23")
      expect(resource.url).to eq("/crm/Contacts?$filter=ID eq guid'23'")
    end

    it "should apply no filters for find_all" do
      resource = Elmas::Contact.new(id: "23", name: "Karel")
      expect(resource).to receive(:find) { "/crm/Contacts" }
      resource.find_all
    end

    it "should apply given filters for find_by" do
      resource = Elmas::Contact.new(id: "23", name: "Karel")
      expect(resource).to receive(:find) { "/crm/Contacts?$filter=name eq 'Karel'&$filter=ID eq guid'23'" }
      resource.find_by([:name, :id])
    end
  end
end
