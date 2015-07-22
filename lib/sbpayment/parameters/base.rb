module Sbpayment
  module Parameters
    class Base
      attr_reader :attributes, :sps_hashcode

      def initialize(attributes)
        @xml = Builder::XmlMarkup.new(indent: 2)
        @xml.instruct!(:xml, encoding: 'Shift_JIS')
        @attributes   = convert_tosjis attributes
        @sps_hashcode = build_hashcode
      end

      # TODO consider how to validate
      def valid?
        raise NotImplementedError
      end

      def to_xml
        # TODO needs to change this id as dynamic
        @xml.tag! 'sps-api-request', id: "ST01-00101-101" do
          @attributes.each do |key, value|
            if value.is_a? Hash
              @xml.tag! key do
                value.each do |k, v|
                  @xml.tag! k, v
                end
              end
            else
              if key == :item_name # TODO consider multibyte
                @xml.tag! key, Base64.strict_encode64(value)
              else
                @xml.tag! key, value
              end
            end
          end
          @xml.sps_hashcode @sps_hashcode
        end
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
