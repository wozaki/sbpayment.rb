module Sbpayment
  module Parameters
    class Credit < Sbpayment::Parameters::Base
      attr_reader :attributes

      def initialize(attributes = nil)
        super
        @attributes   = convert_tosjis attributes
        @sps_hashcode = build_hashcode
      end

      private

      def convert_tosjis(hash)
        hash.each do |k, v|
          if v.is_a?(Hash)
            convert_tosjis(v)
          else
            hash[k] = v.tosjis
          end
        end
      end

      def build_hashcode
        Digest::SHA1.hexdigest @attributes.values.map { |v|
          v.is_a?(Hash) ? v.values.join : v
        }.join
      end
    end
  end
end
