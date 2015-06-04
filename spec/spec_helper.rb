begin
  require 'simplecov'
rescue LoadError
  # ignore
else
  SimpleCov.start do
    add_group 'Elmas', 'lib/elmas'
    add_group 'Faraday Middleware', 'lib/faraday'
    add_group 'Specs', 'spec'
  end
end

require File.expand_path('../../lib/elmas', __FILE__)

require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end
