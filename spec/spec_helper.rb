require 'simplecov'
SimpleCov.start

if ENV['CI']=='true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'rspec'
require 'pivotal'

RSpec.configure do |c|
  c.before(:example) { stub_const("Pivotal::Request::TOKEN", 'abcdefgh123456789zyxwvut') }
  c.before(:example) { stub_const("Pivotal::Request::PROJECT", '1234567') }
end
