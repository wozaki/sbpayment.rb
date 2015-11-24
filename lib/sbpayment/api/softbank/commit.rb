require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Softbank
      class CommitRequest < Request
        tag 'sps-api-request', id: 'ST02-00201-405'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.default_service_id }
        key :tracking_id
        key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
        key :limit_second
        key :sps_hashcode
      end

      class CommitResponse < Response
      end
    end
  end
end

