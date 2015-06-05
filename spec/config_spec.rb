require "spec_helper"

describe Elmas do
  it "has a config" do
    expect(Elmas.config[:base_url]).to eq("https://start.exactonline.nl/")
  end

  let(:new_url) { "www.google.com/api" }

  it "can set a config var" do
    Elmas.configure do |config|
      config.base_url = new_url
    end
    
    expect(Elmas.config[:base_url]).to eq(new_url)
  end
end
