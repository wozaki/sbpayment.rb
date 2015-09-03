require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Au
      class RefundRequest < Request
        class PayOptionManage
          include ParameterDefinition

          tag 'pay_option_manage'
          key :amount
        end

        tag 'sps-api-request', id: 'ST02-00303-402'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.service_id }
        key :tracking_id
        key :pay_option_manage, class: PayOptionManage
        key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
        key :limit_second
        key :sps_hashcode
      end

      class RefundResponse < Response
      end
    end
  end
end
