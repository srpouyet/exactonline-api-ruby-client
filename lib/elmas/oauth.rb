require "mechanize"
require "uri"
require File.expand_path("../utils", __FILE__)
require "pry"
require "faraday/detailed_logger"
require "typhoeus"

## DOES NOT WORK, CONFIGURE WITH OTHERWISE OBTAINED CODE RIGHT NOW
# from https://developers.exactonline.com/#Example retrieve access token.html
module Elmas
  module OAuth
    def authorize(user_name, password, options = {})
      agent = Mechanize.new
      agent.get(authorize_url(options)) do |page|
        form = page.forms.first
        form["UserNameField"] = user_name
        form["PasswordField"] = password
        form.click_button
      end
      code = URI.unescape(agent.page.uri.query.split("=").last)
      uri = agent.page.uri.to_s
      get_access_token(code, uri)
    end

    def authorized?
      response = get("/Current/Me", no_division: true)
      !response.unauthorized?
      # Do a test call, return false if 401 or any error code
    end

    # Return URL for OAuth authorization
    def authorize_url(options = {})
      options[:response_type] ||= "code"
      options[:redirect_uri] ||= redirect_uri
      params = authorization_params.merge(options)
      uri = URI("https://start.exactonline.nl/api/oauth2/auth/")
      uri.query = URI.encode_www_form(params)
      uri.to_s
    end

    # Return an access token from authorization
    def get_access_token(code, uri, options = {})
      conn = Faraday.new(url: "https://start.exactonline.nl") do |faraday|
        faraday.request :url_encoded             # form-encode POST params
        faraday.adapter Faraday.default_adapter  # make requests with Net::HTTP
        faraday.response :detailed_logger
      end
      params = access_token_params(code, uri)
      binding.pry
      # conn.post do |req|
      #   req.url "/api/oauth2/token"
      #   req.body = params
      #   req.headers['Accept'] = 'application/json'
      # end
      Typhoeus.post("http://start.exactonline.nl/api/oauth2/token", body: params)
    end

    private

    def authorization_params
      {
        client_id: client_id
      }
    end

    def access_token_params(code, uri)
      {
        client_id: client_id,
        client_secret: client_secret,
        grant_type: "authorization_code",
        code: code,
        redirect_uri: uri
      }
    end
  end
end
