require_relative '../../callback_request'
require_relative '../../callback_response'

module Sbpayment
  module API
    module Webcvs
      class NoticeRequest < CallbackRequest
        DECRYPT_PARAMETERS = %i(pay_method_info.rec_type
                                pay_method_info.rec_amount
                                pay_method_info.rec_amount_total
                                pay_method_info.rec_mail
                                pay_method_info.rec_extra).freeze
      end

      class NoticeResponse < CallbackResponse
        tag 'sps-api-response', id: 'NT01-00103-701'
        key :res_result
        key :res_err_msg, type: :M
      end
    end
  end
end
