$LOAD_PATH.unshift File.expand_path(__dir__)
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

if RUBY_VERSION >= '1.9'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

  SimpleCov.start do
    minimum_coverage(78.48)
  end
end

require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'shape-api'
require 'byebug'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include Rack::Test::Methods
  config.include WebMock::API

  config.before(:each) do
    @api_token = 'test-12323'
    ShapeApi::Base.configure(
      api_token: @api_token,
    )
  end
end

RSpec::Matchers.define :json_body_including do |json|
  match do |actual|
    json.all? { |k, v| actual.include? "#{k.to_json}:#{v.to_json}" }
  end
end
