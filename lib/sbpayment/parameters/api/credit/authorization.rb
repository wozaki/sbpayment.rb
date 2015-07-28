module Sbpayment
  module Parameters
    module Api
      module Credit
        class Authorization < ::Sbpayment::Parameters::Base
          def initialize(attributes)
            super
          end

          def sps_api_request_id
            'ST01-00111-101'
          end

          def valid?
            # TODO how to validate? might use this kinda gems: https://github.com/jamesbrooks/hash_validator
            # or XSD?
            return false unless @attributes.has_key? :merchant_id
            return false unless @attributes.has_key? :service_id
            return false unless @attributes.has_key? :cust_code
            return false unless @attributes.has_key? :order_id
            return false unless @attributes.has_key? :item_id
            return false unless @attributes.has_key? :amount
            return false unless @attributes.has_key? :request_date
            true
          end
        end
      end
    end
  end
end
