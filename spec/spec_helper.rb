# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'pry'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() App end
end

Dir.glob("spec/support/*.rb").each { |r| require_relative "../#{r}" }

RSpec.configure do |config|
  config.include RSpecMixin
  config.include AuthHelpers
end
