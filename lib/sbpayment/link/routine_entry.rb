require_relative '../parameter_definition'

module Sbpayment
  module Link
    # D01-1
    class RoutineEntry
      include ParameterDefinition

      key :pay_method
      key :merchant_id, default: -> { Sbpayment.config.merchant_id }
      key :service_id,  default: -> { Sbpayment.config.service_id }
      key :cust_code
      key :order_id
      key :item_id
      key :item_name, type: :M
      key :service_type
      key :tracking_id
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
