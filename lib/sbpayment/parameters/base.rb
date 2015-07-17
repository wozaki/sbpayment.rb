module Sbpayment
  module Parameters
    class Base
      attr_reader :attributes

      def initialize(attributes = nil)
        @xml = Builder::XmlMarkup.new(indent: 2)
        @xml.instruct!(:xml, encoding: 'Shift_JIS')
      end

      # TODO consider how to validate
      def valid?
        true
      end

      def to_xml
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
    end
  end
end
