require 'xmlsimple'
require_relative 'shallow_hash'
require_relative 'decode_parameters'
require_relative 'parameter_definition'

module Sbpayment
  class CallbackRequest
    using ShallowHash

    include DecodeParameters
    include ParameterDefinition

    attr_reader :headers, :body

    def initialize(headers, body, need_decrypt: false)
      @headers = headers
      @body    = XmlSimple.xml_in(body, forcearray: false, noattr: true, keytosymbol: true, suppressempty: true).shallow
      @body    = decode @body, need_decrypt
    end

    def response_class
      self.class.const_get self.class.name.sub(/Request\z/, 'Response')
    end
  end
end
