require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Credit
      class PartlyRefundRequest < Request
        class PayOptionManage
          include ParameterDefinition

          tag 'pay_option_manage'
          key :amount
        end

        tag 'sps-api-request', id: 'ST02-00307-101'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.default_service_id }
        key :sps_transaction_id
        key :tracking_id
        key :processing_datetime
        key :pay_option_manage, class: PayOptionManage
        key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
        key :limit_second
        key :sps_hashcode
      end

      class PartlyRefundResponse < Response
      end
    end
  end
end
