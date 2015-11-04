require_relative 'definitions'

module Sbpayment
  module APIError
    module PaymentMethodClassResponsible
      module ClassMethods
        # @return [self::PaymentMethod]
        def payment_method
          self::PAYMENT_METHOD
        end
      end

      class << self
        def included(mod)
          mod.class_eval do
            extend ClassMethods
          end
        end
      end

      # @return [PaymentMethod]
      def payment_method
        self.class.payment_method
      end
    end

    module TypeClassResponsible
      module ClassMethods
        # @return [self::Type]
        def type
          self::TYPE
        end
      end

      class << self
        def included(mod)
          mod.class_eval do
            extend ClassMethods
          end
        end
      end

      def type
        self.class.type
      end
    end
  end
end
