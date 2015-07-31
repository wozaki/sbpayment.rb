require_relative 'shallow_hash'
require_relative 'decrypt_parameters'

module Sbpayment
  class Response
    using ShallowHash

    include DecryptParameters

    attr_reader :status, :headers, :body

    def initialize(status, headers, body, need_decrypt: false)
      @status  = status
      @headers = headers
      @body    = XmlSimple.xml_in(body, forcearray: false, noattr: true, keytosymbol: true, suppressempty: true).shallow
      @body    = decrypt @body if need_decrypt
    end
  end
end
