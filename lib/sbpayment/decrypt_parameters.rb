require_relative 'crypto'

module Sbpayment
  module DecryptParameters
    def decrypt(parameters)
      return parameters unless self.class.const_defined?('DECRYPT_PARAMETERS')
      self.class.const_get('DECRYPT_PARAMETERS').each do |key|
        next unless parameters.key? key
        parameters[key] = Sbpayment::Crypto.decrypt parameters[key]
      end
      parameters
    end
  end
end





