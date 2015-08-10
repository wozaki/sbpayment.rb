require_relative '../request'
require_relative '../response'

module Sbpayment
  module API
    class ReadCustomerRequest < Request
      class PayOptionManage
        include ParameterDefinition

        tag 'pay_option_manage'
        key :cardbrand_return_flg, default: '1'
      end

      tag 'sps-api-request', id: 'MG02-00104-101'
      key :merchant_id, default: -> { Sbpayment.config.merchant_id }
      key :service_id,  default: -> { Sbpayment.config.service_id }
      key :cust_code
      key :sps_cust_info_return_flg, default: '1'
      key :response_info_type, default: '2'
      key :pay_option_manage, class: PayOptionManage
      key :encrypted_flg, default: '1'
      key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
      key :limit_second
      key :sps_hashcode
    end

    class ReadCustomerResponse < Response
      DECRYPT_PARAMETERS = %i(res_pay_method_info.cc_number
                              res_pay_method_info.cc_expiration
                              res_pay_method_info.cardbrand_code
                              res_pay_method_info.resrv1
                              res_pay_method_info.resrv2
                              res_pay_method_info.resrv3).freeze
    end
  end
end
