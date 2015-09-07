require 'openssl'
require_relative 'configuration'

module Sbpayment
  module Crypto
    module_function

    def encrypt(data)
      self.check_cipher_keys!

      cipher = OpenSSL::Cipher.new 'DES3'
      cipher.encrypt
      cipher.key = Sbpayment.config.cipher_code
      cipher.iv  = Sbpayment.config.cipher_iv
      cipher.padding = 0

      q, r = data.bytesize.divmod 8
      data += ' ' * ((8 * (q + 1)) - data.bytesize) if r > 0

      cipher.update(data) + cipher.final
    end

    def decrypt(data)
      self.check_cipher_keys!

      cipher = OpenSSL::Cipher.new 'DES3'
      cipher.decrypt
      cipher.key = Sbpayment.config.cipher_code
      cipher.iv  = Sbpayment.config.cipher_iv
      cipher.padding = 0

      (cipher.update(data) + cipher.final).sub(/ +\z/, '') # or use String#rstrip
    end

    def check_cipher_keys!
      if Sbpayment.config.cipher_code.nil? || Sbpayment.config.cipher_iv.nil?
        raise ArgumentError.new 'Either Sbpayment.config.cipher_code or Sbpayment.config.cipher_iv are not defined.'
      end
    end
  end
end
