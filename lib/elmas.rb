require "elmas/version"
require "elmas/api"
require "elmas/config"
require "elmas/response"
require "elmas/client"
require "elmas/log"
require "elmas/resource"
require "elmas/resources/contact"
require "elmas/resources/invoice"
require "elmas/resources/journal"
require "elmas/resources/item"
require "elmas/resources/invoice_line"
require "elmas/resources/account"
require "elmas/resources/sales_entry"
require "elmas/resources/sales_entry_line"

module Elmas
  extend Config
  extend Log

  def self.client(options = {})
    Elmas::Client.new(options)
  end

  # Delegate to Elmas::Client
  def self.method_missing(method, *args, &block)
    super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Elmas::Client
  def self.respond_to?(method, include_all = false)
    client.respond_to?(method, include_all) || super
  end
end
