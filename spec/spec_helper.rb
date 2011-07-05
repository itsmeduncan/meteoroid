require "bundler"
Bundler.setup

$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'meteoroid'

RSpec.configure do |config|
  config.mock_with :mocha
end
