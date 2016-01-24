require 'rspec'
require 'pivotal/api'
require 'pivotal/request'
require 'pivotal/label'
require 'pivotal/story'
require 'pivotal/project'

RSpec.configure do |c|
  c.before(:example) { stub_const("Pivotal::Request::TOKEN", 'abcdefgh123456789zyxwvut') }
  c.before(:example) { stub_const("Pivotal::Request::PROJECT", '1234567') }
end
