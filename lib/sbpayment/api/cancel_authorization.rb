require_relative '../request'
require_relative '../response'

module Sbpayment
  module API
    class CancelAuthorizationRequest < Request
      tag 'sps-api-request', id: 'ST02-00305-101'
      key :merchant_id, default: -> { Sbpayment.config.merchant_id }
      key :service_id,  default: -> { Sbpayment.config.service_id }
      key :sps_transaction_id
      key :tracking_id
      key :processing_datetime
      key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
      key :limit_second
      key :sps_hashcode
    end

    class CancelAuthorizationResponse < Response
    end
  end
end
