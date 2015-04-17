require 'faraday'

module Elmas
  module Config
    # An array of valid keys in the options hash
    VALID_OPTIONS_KEYS = [
      :access_token,
      :adapter,
      :client_id,
      :client_secret,
      :connection_options,
      :redirect_uri,
      :response_format,
      :user_agent,
      :endpoint,
      :division,
      :base_url
    ].freeze

    # By default, don't set a user access token
    DEFAULT_ACCESS_TOKEN = "Bearer gAAAACL9WnEMG1TNeO56TZJsTiWVvExd9cyqku9K58U5fbw28M_EfvTqtcwlHv7Q-qyThxJVf0ltvlO7cCNtPQyXVfh252IHxIB45Vt7osKZW6zxpJ3Nl7xndHcPAGY9IQj0ESD_M543xjYpzwb8D1r2rV1fUFSs3d2hEWlqSpLsy34mFAEAAIAAAAC2RXGKqu90HnYBEz5PBSMeIRW4yeSYfuXnF2P4gVwG1dBSeJXsnfFQ3xj8sWLpMLVrcrhYVdM5iLgyK4InHOUQYVHlaWCEhxgQ1q5z3lTJ6bIkNj9i3VN5uuO46H02gQKRpvn0RO9oCwXgXa7E_0ujg9vLk9cWJYXTf4ygihTzi2ttK9WpfxW3a72o2buphTuZIqOzxrMmrAuRBXNnB8OT0vICwAHc77mBFYF6r21M1dwLvbiu3Ommt7LU_0qJPMm2h8V9HIBwlmPB0ygOgyy6nOp14QuBc2a35_Zclr9HFG3LhGgyXTss8jDCGGly6PJdtfAoQ2D5RZaYV1emx9w7QxmMJVQQFWDuqUqVv4wP4w"

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, client id should be set in .env
    DEFAULT_CLIENT_ID = nil

    # By default, client secret should be set in .env
    DEFAULT_CLIENT_SECRET = nil

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    DEFAULT_BASE_URL = "https://start.exactonline.nl/api/v1"

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = "/api/v1".freeze

    #the division code you want to connect with
    DEFAULT_DIVISION = nil

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    DEFAULT_FORMAT = :json

    # By default, don't set an application redirect uri
    DEFAULT_REDIRECT_URI = "https://www.getpostman.com/oauth2/callback"

    # By default, don't set user agent
    DEFAULT_USER_AGENT = nil

    # An array of valid request/response formats
    VALID_FORMATS = [:json].freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.access_token       = DEFAULT_ACCESS_TOKEN
      self.adapter            = DEFAULT_ADAPTER
      self.client_id          = DEFAULT_CLIENT_ID
      self.client_secret      = DEFAULT_CLIENT_SECRET
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.redirect_uri       = DEFAULT_REDIRECT_URI
      self.endpoint           = DEFAULT_ENDPOINT
      self.division           = DEFAULT_DIVISION
      self.base_url           = DEFAULT_BASE_URL
      self.response_format    = DEFAULT_FORMAT
      self.user_agent         = DEFAULT_USER_AGENT
    end
  end
end
