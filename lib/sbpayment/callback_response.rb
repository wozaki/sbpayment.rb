require_relative 'parameter_definition'

module Sbpayment
  class CallbackResponse
    include ParameterDefinition

    def to_xml
      to_sbps_xml
    end
  end
end
