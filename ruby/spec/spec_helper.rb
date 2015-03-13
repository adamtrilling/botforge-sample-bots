ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'bundler'
Bundler.require
require 'pry'

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require File.expand_path '../../sample_bots.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() SampleBots end
end

RSpec.configure do |config| 
  config.include RSpecMixin

  config.color = true

  config.before(:each) do
  end

  config.after(:each) do
  end
end