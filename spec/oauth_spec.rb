require "spec_helper"

describe Elmas::OAuth do
  describe "#" do
    it "authorize" do
      stub_request(:get, "https://start.exactonline.nl/api/oauth2/auth/?client_id=client_id&redirect_uri=redirect_uri&response_type=code").
               with(:headers => {'Accept'=>'*/*', 'Accept-Charset'=>'ISO-8859-1,utf-8;q=0.7,*;q=0.7', 'Accept-Encoding'=>'gzip,deflate,identity', 'Accept-Language'=>'en-us,en;q=0.5', 'Connection'=>'keep-alive', 'Host'=>'start.exactonline.nl', 'Keep-Alive'=>'300', 'User-Agent'=>'Mechanize/2.7.3 Ruby/2.1.2p95 (http://github.com/sparklemotion/mechanize/)'}).
               to_return(:status => 200, :body => "", :headers => {})
      response = Elmas.authorize('MarthynOlthof', 'Mo003423')
      expect(response.status).to eq(200)
    end
  end
end
