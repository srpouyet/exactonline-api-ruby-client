require 'spec_helper'

describe Elmas::Request do
  let(:base_url) { "https://start.exactonline.nl" }
  let(:endpoint) { "api/v1" }
  let(:division) { "2332" }

  let(:url_with_endpoint_and_division) { "#{base_url}/#{endpoint}/#{division}"}
  let(:url_with_endpoint) { "#{base_url}/#{endpoint}"}
  let(:url_with_division) { "#{base_url}/#{division}"}

  before :each do
    Elmas.configure do |config|
      config.base_url = base_url
      config.endpoint = endpoint
      config.division = division
    end
  end

  it "does a get request" do
    stub_request(:get, "#{url_with_endpoint_and_division}/resource")
    expect(Elmas.get("resource")).to be_a(Elmas::Response)
  end

  it "does a get request without endpoint" do
    stub_request(:get, "#{url_with_division}/resource")
    expect(Elmas.get("resource", no_endpoint: true)).to be_a(Elmas::Response)
  end

  it "does a get request without division" do
    stub_request(:get, "#{url_with_endpoint}/resource")
    expect(Elmas.get("resource", no_division: true)).to be_a(Elmas::Response)
  end

  it "does a get request with params" do
    random_id = rand(999).to_s
    stub_request(:get, "#{url_with_endpoint_and_division}/salesinvoice/SalesInvoices?$filter=ID%20eq%20guid'#{random_id}'")
    resource = Elmas::Invoice.new(id: random_id)
    response = resource.find
    expect(response).to be_a(Elmas::Response)
  end

  it "does a post request" do
    params = { first_name: "Piet", last_name: "Mondriaan", account: 1 }
    stub_request(:post, "https://start.exactonline.nl/api/v1/2332/crm/Contacts").
            with(body: params.to_json)
    resource = Elmas::Contact.new(params)
    response = resource.save
    expect(response).to be_a(Elmas::Response)
  end

  it "does a put request" do
    params = { id: 1, first_name: "Karel", last_name: "Appel", account: 1 }
    stub_request(:put, "https://start.exactonline.nl/api/v1/2332/crm/Contacts").
            with(body: params.to_json)
    resource = Elmas::Contact.new(params)
    response = resource.save
    expect(response).to be_a(Elmas::Response)
  end

  it "does a delete request" do

  end
end
