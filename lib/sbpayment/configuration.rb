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

  class ConfigrationError < StandardError; end

  class Config
    include Singleton

    attr_accessor :sandbox
    attr_accessor :basic_auth_user, :basic_auth_password
    attr_accessor :merchant_id, :service_id
    attr_accessor :cipher_code, :cipher_iv
    attr_accessor :hashkey
    attr_accessor :proxy_uri, :proxy_user, :proxy_password

    def initialize
      @multiple_service_id = false
    end

    def enable_multiple_service_id
      @multiple_service_id = true
    end

    def disable_multiple_service_id
      @multiple_service_id = false
    end

    def multiple_service_id?
      @multiple_service_id
    end

    def default_service_id
      if multiple_service_id?
        raise ConfigrationError, 'need to set service_id in multiple service_id mode'
      else
        service_id
      end
    end
  end
end
