require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Credit
      class InquireAuthorizationRequest < Request
        class PayOptionManage
          include ParameterDefinition

          tag 'pay_option_manage'
          key :cardbrand_return_flg, default: '1'
        end

        tag 'sps-api-request', id: 'MG01-00101-101'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.service_id }
        key :sps_transaction_id
        key :tracking_id
        key :response_info_type, default: '2'
        key :pay_option_manage, class: PayOptionManage
        key :encrypted_flg, default: '1'
        key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
        key :limit_second
        key :sps_hashcode
      end

      class InquireAuthorizationResponse < Response
        DECRYPT_PARAMETERS = %i(res_pay_method_info.res_pay_method_info_detail.cc_number
                                res_pay_method_info.res_pay_method_info_detail.cc_expiration
                                res_pay_method_info.res_pay_method_info_detail.dealings_type
                                res_pay_method_info.res_pay_method_info_detail.divide_times
                                res_pay_method_info.cc_company_code
                                res_pay_method_info.cardbrand_code
                                res_pay_method_info.recognized_no
                                res_pay_method_info.commit_status
                                res_pay_method_info.payment_status).freeze
      end
    end
  end
end
