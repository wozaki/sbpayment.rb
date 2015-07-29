module Sbpayment
  module Parameters
    KeyNotFoundError = Class.new StandardError

    module KeyValidator
      def self.included(klass)
        klass.extend ClassMethods
      end

      module ClassMethods
        def sbp_keys
          @sbp_keys ||= if superclass.included_modules.include? KeyValidator
                          superclass.sbp_keys.dup
                        else
                          []
                        end
        end

        def sbp_keys=(val)
          @sbp_keys = val
        end

        def sbp_key(*keys)
          self.sbp_keys |= keys.map(&:to_sym)
        end
      end

      def validate_sbp_keys
        begin
          validate_sbp_keys!
        rescue KeyNotFoundError
          false
        end
      end

      def validate_sbp_keys!
        self.class.sbp_keys.each do |sbp_key|
          validate_sbp_key sbp_key, attributes
        end
        true
      end

      private

      def validate_sbp_key(sbp_key, attributes)
        sbp_key.to_s.split('.').each do |key|
          if attributes.key? key.to_sym or attributes.key? key.to_s
            attributes = attributes[key.to_sym] || attributes[key.to_s]
          else
            raise KeyNotFoundError, "#{sbp_key} is not exist"
          end
        end
      end
    end
  end
end
