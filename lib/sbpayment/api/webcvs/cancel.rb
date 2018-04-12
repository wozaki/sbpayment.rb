require_relative '../../callback_request'
require_relative '../../callback_response'

module Sbpayment
  module API
    module Webcvs
      class CancelRequest < CallbackRequest
      end

      class CancelResponse < CallbackResponse
        tag 'sps-api-response', id: 'NT01-00104-701'
        key :res_result
        key :res_err_msg, type: :M
      end
    end
  end
end
