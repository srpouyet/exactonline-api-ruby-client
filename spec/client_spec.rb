require 'spec_helper'

describe Elmas::Client do
  it "should connect using the endpoint configuration" do
    client = Elmas::Client.new
    connection = client.send(:connection).build_url(client.endpoint).to_s
    (connection).should == client.base_url + client.endpoint
  end
end
