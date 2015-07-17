$LOAD_PATH.unshift(__dir__)
$LOAD_PATH.unshift(File.join(__dir__, '..', 'lib'))

require 'sbpayment'
require 'rspec'
require 'webmock/rspec'
require 'vcr'

$test_env = true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.default_cassette_options = {
    serialize_with: :syck
  }
end

RSpec.configure do |config|
  config.include WebMock::API
  config.extend VCR::RSpec::Macros
end
