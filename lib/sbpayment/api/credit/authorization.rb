require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Credit
      class AuthorizationRequest < Request
        class Detail
          include ParameterDefinition

          tag 'dtl'
          key :dtl_rowno
          key :dtl_item_id
          key :dtl_item_name, type: :M
          key :dtl_item_count
          key :dtl_tax
          key :dtl_amount
        end
        class PayMethodInfo
          include ParameterDefinition

          tag 'pay_method_info'
          key :cc_number,     encrypt: true
          key :cc_expiration, encrypt: true
          key :security_code, encrypt: true
          key :dealings_type, encrypt: true
          key :divide_times,  encrypt: true
        end
        class PayOptionManage
          include ParameterDefinition

          tag 'pay_option_manage'
          key :cust_manage_flg
          key :cardbrand_return_flg, default: '1'
        end

        tag 'sps-api-request', id: 'ST01-00111-101'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.default_service_id }
        key :cust_code
        key :order_id
        key :item_id
        key :item_name, type: :M
        key :tax
        key :amount
        key :free1, type: :M
        key :free2, type: :M
        key :free3, type: :M
        key :order_rowno
        key :sps_cust_info_return_flg, default: '1'
        many :dtls
        key :pay_method_info, class: PayMethodInfo
        key :pay_option_manage, class: PayOptionManage
        key :encrypted_flg, default: '1'
        key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
        key :limit_second
        key :sps_hashcode
      end

      class AuthorizationResponse < Response
        DECRYPT_PARAMETERS = %i(res_pay_method_info.cc_company_code
                                res_pay_method_info.cardbrand_code
                                res_pay_method_info.recognized_no).freeze
      end
    end
  end
end
