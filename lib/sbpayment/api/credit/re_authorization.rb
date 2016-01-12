require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Credit
      class ReAuthorizationRequest < Request
        class Detail
          include ParameterDefinition

          tag 'dtl'
          key :dtl_rowno
          key :dtl_item_id
          key :dtl_item_name
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
          key :resrv1,        encrypt: true
          key :resrv2,        encrypt: true
          key :resrv3,        encrypt: true
        end
        class PayOptionManage
          include ParameterDefinition

          tag 'pay_option_manage'
          key :cust_manage_flg
          key :cardbrand_return_flg, default: '1'
          key :pay_info_control_type
          key :pay_info_detail_control_type
        end

        tag 'sps-api-request', id: 'ST01-00113-101'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.default_service_id }
        key :tracking_id
        key :cust_code
        key :order_id
        key :item_id
        key :item_name
        key :tax
        key :amount
        key :free1
        key :free2
        key :free3
        key :order_rowno
        key :sps_cust_info_return_flg, default: '1'
        many :dtls
        key :pay_method_info, class: PayMethodInfo
        key :pay_option_manage, class: PayOptionManage
        key :encrypted_flg, default: '1'
        key :request_date, default: -> { TimeUtil.format_current_time }
        key :limit_second
        key :sps_hashcode
      end

      class ReAuthorizationResponse < Response
        DECRYPT_PARAMETERS = %i(res_pay_method_info.cc_company_code
                                res_pay_method_info.cardbrand_code
                                res_pay_method_info.recognized_no).freeze
      end
    end
  end
end
