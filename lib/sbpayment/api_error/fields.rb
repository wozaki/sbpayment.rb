module Sbpayment
  module APIError
    class Field
      class << self
        # @param code [String]
        # @return [self]
        def fetch(code)
          check_code code
          @children[code]
        end

        # @param code [String]
        def valid_code?(code)
          !! self::PATTERN.match(code)
        end

        def check_code(code)
          valid_code?(code) || raise(ArgumentError, "invalid code is given: #{code}")
        end

        private

        def inherited(subclass)
          subclass.class_eval do
            @children = Hash.new { |pool, code| pool[code] = new(code: code) }
          end
        end

        def define_children_from(definitions)
          definitions.each_pair do |code, summary|
            @children[code] = new(code: code, summary: summary)
          end
        end
      end

      attr_reader :code, :summary
      alias_method :to_s, :code

      def initialize(code:, summary: nil)
        self.class.check_code code
        @code = code
        @summary = summary
      end
    end

    class PaymentMethod < Field
      PATTERN = /\A[0-9a-zA-Z]{3}\z/

      define_children_from PAYMENT_METHOD_DEFINITIONS
    end

    class Type < Field
      PATTERN = /\A[0-9a-zA-Z]{2}\z/
    end

    class Item < Field
      PATTERN = /\A[0-9a-zA-Z]{3}\z/
    end
  end
end
