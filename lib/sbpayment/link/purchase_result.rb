require_relative '../parameter_definition'

module Sbpayment
  module Link
    # A03-1
    class PurchaseResult
      include ParameterDefinition

      key :pay_method
      key :merchant_id
      key :service_id
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
      key :free1, type: :M
      key :free2, type: :M
      key :free3, type: :M
      key :request_date
      key :res_pay_method
      key :res_result
      key :res_tracking_id
      key :res_sps_cust_no
      key :res_sps_payment_no
      key :res_payinfo_key
      key :res_payment_date
      key :res_err_code
      key :res_date
      key :limit_second
      key :sps_hashcode

      def validate_sps_hashcode
        raise 'invalid sps_hashcode' unless sps_hashcode == generate_sps_hashcode
      end
    end
  end
end
