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

    attr_accessor :sandbox
    attr_accessor :basic_auth_user, :basic_auth_password
    attr_accessor :merchant_id, :service_id
    attr_accessor :cipher_code, :cipher_iv
    attr_accessor :hashkey
  end
end
