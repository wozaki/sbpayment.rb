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

    OPTION_KEYS = %i[
      sandbox
      basic_auth_user
      basic_auth_password
      merchant_id
      service_id
      cipher_code
      cipher_iv
      hashkey
      proxy_uri
      proxy_user
      proxy_password
      allow_multiple_service_id
    ].freeze

    attr_accessor(*OPTION_KEYS)

    def initialize
      @sandbox = false
      @allow_multiple_service_id = false
    end

    def []=(name, value)
      __send__ "#{name}=", value
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
