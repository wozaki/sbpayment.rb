require_relative '../parameter_definition'

module Sbpayment
  module Link
    # B01-1
    class UpdateRequest
      include ParameterDefinition

      key :pay_method
      key :merchant_id, default: -> { Sbpayment.config.merchant_id }
      key :service_id,  default: -> { Sbpayment.config.default_service_id }
      key :cust_code
      key :sps_cust_no
      key :sps_payment_no
      key :terminal_type
      key :success_url
      key :cancel_url
      key :error_url
      key :pagecon_url
      key :free1, type: :M
      key :free2, type: :M
      key :free3, type: :M
      key :request_date, default: -> { TimeUtil.format_current_time }
      key :limit_second
      key :sps_hashcode

      def generate_sps_hashcode(encoding: 'UTF-8')
        super
      end
    end
  end
end
