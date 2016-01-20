require 'singleton'

module Sbpayment
  module Configuration
    def configure
      yield config
    end

    def config
      Config.instance
    end
  end
  extend Configuration

  class ConfigurationError < Sbpayment::Error; end

  class Config
    include Singleton

    attr_accessor :sandbox
    attr_accessor :basic_auth_user, :basic_auth_password
    attr_accessor :merchant_id, :service_id
    attr_accessor :cipher_code, :cipher_iv
    attr_accessor :hashkey
    attr_accessor :proxy_uri, :proxy_user, :proxy_password
    attr_accessor :allow_multiple_service_id

    def initialize
      @sandbox = false
      @allow_multiple_service_id = false
    end

    def default_service_id
      if !allow_multiple_service_id && service_id.nil?
        raise ConfigurationError, 'needs to set service_id unless multiple service_id mode'
      else
        service_id
      end
    end
  end
end
