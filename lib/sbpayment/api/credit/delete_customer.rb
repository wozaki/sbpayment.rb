require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Credit
      class DeleteCustomerRequest < Request
        tag 'sps-api-request', id: 'MG02-00103-101'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.default_service_id }
        key :cust_code
        key :sps_cust_info_return_flg, default: '1'
        key :encrypted_flg, default: '1'
        key :request_date, default: -> { Time.now.strftime('%Y%m%d%H%M%S') }
        key :limit_second
        key :sps_hashcode
      end

      class DeleteCustomerResponse < Response
      end
    end
  end
end
