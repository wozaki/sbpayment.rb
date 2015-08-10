require 'sbpayment/version'
require 'sbpayment/const'
require 'sbpayment/configuration'

Dir[File.join __dir__, 'sbpayment/api/**/*.rb'].each { |file| require file }
Dir[File.join __dir__, 'sbpayment/link/**/*.rb'].each { |file| require file }
