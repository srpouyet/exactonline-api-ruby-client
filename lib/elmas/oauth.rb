require "mechanize"
require "uri"
require File.expand_path('../utils', __FILE__)
require "pry"
require "faraday/detailed_logger"

## DOES NOT WORK, CONFIGURE WITH OTHERWISE OBTAINED CODE RIGHT NOW
# from https://developers.exactonline.com/#Example retrieve access token.html
module Elmas
  module OAuth
    def authorize(user_name, password, options={})
      agent = Mechanize.new
      agent.get(authorize_url(options)) do |page|
        form = page.forms.first
        form["UserNameField"] = user_name
        form["PasswordField"] = password
        page = form.click_button
      end
      code = agent.page.uri.query.split('=').last
      uri = agent.page.uri.to_s
      token = get_access_token(code, uri)
    end

    def authorized?
      response = get("/Current/Me", no_division: true)
      !response.unauthorized?
      #Do a test call, return false if 401 or any error code
    end

    # Return URL for OAuth authorization
    def authorize_url(options={})
      options[:response_type] ||= "code"
      options[:redirect_uri] ||= self.redirect_uri
      params = authorization_params.merge(options)
      uri = URI("http://start.exactonline.nl/api/oauth2/auth/")
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    # Return an access token from authorization
    def get_access_token(code, uri, options={})
      conn = Faraday.new(:url => 'http://start.exactonline.nl') do |faraday|
       faraday.request  :url_encoded             # form-encode POST params
       faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
       faraday.response :detailed_logger
      end
      options[:code] = code
      options[:redirect_uri] ||= uri
      options[:grant_type] ||= "authorization_code"
      params = access_token_params.merge(options)
      binding.pry
      response = conn.post "/api/oauth2/token", params
    end

    private

    def authorization_params
      {
        client_id: client_id
      }
    end

    def access_token_params
      {
        client_id: client_id,
        client_secret: client_secret,
        force_login: "0"
      }
    end
  end
end
