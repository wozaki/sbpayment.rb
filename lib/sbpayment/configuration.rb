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
    RETRY_TIMES = 3

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
      retry_max_counts
    ].freeze

    attr_accessor(*OPTION_KEYS)

    def initialize
      @sandbox = false
      @retry_max_counts = RETRY_TIMES
    end

    def []=(name, value)
      __send__ "#{name}=", value
    end
  end
end
