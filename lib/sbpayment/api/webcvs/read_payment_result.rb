require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Webcvs
      class ReadPaymentResultRequest < Request
        tag 'sps-api-request', id: 'MG01-00101-701'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.default_service_id }
        key :sps_transaction_id
        key :tracking_id
        key :encrypted_flg, default: '1'
        key :request_date, default: -> { TimeUtil.format_current_time }
        key :limit_second
        key :sps_hashcode
      end

      class ReadPaymentResultResponse < Response
        DECRYPT_PARAMETERS = %i(res_pay_method_info.webcvstype
                                res_pay_method_info.invoice_no
                                res_pay_method_info.bill_date
                                res_pay_method_info.cvs_pay_data1
                                res_pay_method_info.cvs_pay_data2
                                res_pay_method_info.payment_status).freeze
      end
    end
  end
end
