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
    ].freeze

    attr_accessor(*OPTION_KEYS)

    def initialize
      @sandbox = false
    end

    def []=(name, value)
      __send__ "#{name}=", value
    end
  end
end
