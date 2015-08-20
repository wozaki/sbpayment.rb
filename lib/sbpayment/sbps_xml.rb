require 'builder/xmlmarkup'

module Sbpayment
  module SbpsXML
    def to_sbps_xml(root: true, need_encrypt: false)
      xml = Builder::XmlMarkup.new
      xml.instruct! :xml, encoding: 'Shift_JIS' if root
      xml.tag! self.class.xml_tag, (self.class.xml_attributes || {}) do
        keys.values.sort_by(&:position).each do |key|
          value = read_params key.name
          case
          when key.klass == Array
            xml.tag! key.xml_tag do
              value.each do |val|
                xml << val.to_sbps_xml(root: false, need_encrypt: need_encrypt)
              end
            end
          when key.klass == String
            xml.tag! key.xml_tag, key.cast_for_xml(value, need_encrypt: need_encrypt) unless value.to_s.empty?
          else
            xml << value.to_sbps_xml(root: false, need_encrypt: need_encrypt)
          end
        end
      end
    end
  end
end
