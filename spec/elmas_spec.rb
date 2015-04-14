require 'spec_helper'

describe Elmas do
  it 'has a version number' do
    expect(Elmas::Version).not_to be nil
  end

  describe ".client" do
    it "should be an Elmas client" do
      Elmas.client.should be_a Elmas::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Elmas.adapter.should == Elmas::Config::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Elmas.adapter = :typhoeus
      Elmas.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Elmas.endpoint.should == Elmas::Config::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Elmas.endpoint = 'http://other_api.com'
      Elmas.endpoint.should == 'http://other_api.com'
    end
  end

  describe ".format" do
    it "should return the default format" do
      Elmas.response_format.should == Elmas::Config::DEFAULT_FORMAT
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Elmas.user_agent.should == Elmas::Config::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Elmas.user_agent = 'Custom User Agent'
      Elmas.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    Elmas::Config::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Elmas.configure do |config|
          config.send("#{key}=", key)
          Elmas.send(key).should == key
        end
      end
    end
  end
end
