require_relative '../parameter_definition'

module Sbpayment
  module Link
    # B03-1
    class UpdateReport
      include ParameterDefinition

      key :pay_method
      key :merchant_id
      key :service_id
      key :cust_code
      key :sps_cust_no
      key :sps_payment_no
      key :terminal_type
      key :free1, type: :M
      key :free2, type: :M
      key :free3, type: :M
      key :request_date
      key :res_pay_method
      key :res_result
      key :res_sps_cust_no
      key :res_sps_payment_no
      key :res_payinfo_key
      key :res_err_code
      key :res_date
      key :limit_second
      key :sps_hashcode

      def validate_sps_hashcode!
        raise InvalidSpsHashcodeError unless sps_hashcode.downcase == generate_sps_hashcode(encoding: 'UTF-8')
      end
    end
  end
end
