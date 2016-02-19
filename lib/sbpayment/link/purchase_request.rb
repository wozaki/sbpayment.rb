require_relative '../parameter_definition'
require_relative 'purchase_request/validators'

module Sbpayment
  module Link
    # A01-1
    class PurchaseRequest
      include ParameterDefinition

      key :pay_method
      key :merchant_id, default: -> { Sbpayment.config.merchant_id }
      key :service_id,  default: -> { Sbpayment.config.service_id }
      key :cust_code
      key :sps_cust_no
      key :sps_payment_no
      key :order_id
      key :item_id
      key :pay_item_id
      key :item_name, type: :M
      key :tax
      key :amount
      key :pay_type
      key :auto_charge_type
      key :service_type
      key :div_settele
      key :last_charge_month
      key :camp_type
      key :tracking_id
      key :terminal_type
      key :success_url
      key :cancel_url
      key :error_url
      key :pagecon_url
      key :free1, type: :M
      key :free2, type: :M
      key :free3, type: :M
      key :free_csv, type: :M
      key :request_date, default: -> { TimeUtil.format_current_time }
      key :limit_second
      key :sps_hashcode

      def generate_sps_hashcode(encoding: 'UTF-8')
        super
      end
    end
  end
end
