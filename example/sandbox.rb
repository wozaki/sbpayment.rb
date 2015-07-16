# Port https://developer.sbpayment.jp/solution_api/sandbox/A090201

require 'pp'
require 'kconv'
require "base64"
require "faraday"
require 'digest/sha1'
require 'securerandom'
require 'builder/xmlmarkup'

params = {
  merchant_id: "30132",
  service_id: "002",
  cust_code: "SPSTestUser0001",
  order_id: SecureRandom.hex, # Needs to be random
  item_id: "ITEMID00000000000000000000000001",
  item_name: "テスト商品",
  tax: "1",
  amount: "1",
  free1: "",
  free2: "",
  free3: "",
  order_rowno: "",
  sps_cust_info_return_flg: "1",
  dtls: '',
  pay_method_info: {
    cc_number: "5250729026209007",
    cc_expiration: "201103",
    security_code: "798",
    cust_manage_flg: "0",
  },
  pay_option_manage: '',
  encrypted_flg: "0",
  request_date: Time.now.strftime("%Y%m%d%H%M%S"), # Needs to be unique
  limit_second: "",
  hashkey: "8435dbd48f2249807ec216c3d5ecab714264cc4a"
}

params.each do |key, value|
  if value.is_a? Hash
    value.each do |k, v|
      params[key][k] = v.tosjis
    end
  else
    params[key] = value.tosjis
  end
end

sps_hashcode = Digest::SHA1.hexdigest params.values.map { |v|
  if v.is_a? Hash
    v.values.join
  else
    v
  end
}.join

xml = Builder::XmlMarkup.new(indent: 2)
xml.instruct!(:xml, encoding: 'Shift_JIS')

xml = xml.tag! 'sps-api-request', id: "ST01-00101-101" do
  params.each do |key, value|
    if value.is_a? Hash
      xml.tag! key do
        value.each do |k, v|
          xml.tag! k, v
        end
      end
    else
      if key == :item_name
        xml.tag! key, Base64.encode64(value).strip
      else
        xml.tag! key, value
      end
    end
  end
  xml.sps_hashcode sps_hashcode
end

# puts xml

url = "https://stbfep.sps-system.com"

conn = Faraday.new(url: url)
conn.basic_auth(params[:merchant_id] + params[:service_id], params[:hashkey])

res = conn.post('/api/xmlapi.do', xml, 'content-type' => 'text/xml')

puts res.body
