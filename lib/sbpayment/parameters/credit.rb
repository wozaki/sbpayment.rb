module Sbpayment
  module Parameters
    class Credit < Sbpayment::Parameters::Base
      def initialize(attributes)
        super
      end

      def valid?
        raise NotImplementedError
      end
    end
  end
end
