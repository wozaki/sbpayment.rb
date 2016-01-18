require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Docomo
      class SimplifiedCancelRefundRequest < Request
        class PayOptionManage
          include ParameterDefinition
          tag 'pay_option_manage'
          key :cancel_target_month
        end

        tag 'sps-api-request', id: 'ST02-00303-401'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.default_service_id }
        key :tracking_id
        key :pay_option_manage, class: PayOptionManage
        key :request_date, default: -> { TimeUtil.format_current_time }
        key :limit_second
        key :sps_hashcode
      end

      class SimplifiedCancelRefundResponse < Response
        DECRYPT_PARAMETERS = %i(res_pay_method_info.res_cancel_type).freeze
      end
    end
  end
end
