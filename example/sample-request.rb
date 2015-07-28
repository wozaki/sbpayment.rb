require 'bundler/setup'
require 'pp'
require 'sbpayment'

params = Sbpayment::Parameters::Api::Credit::Authorization.new({
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
})

if params.valid?
  client = Sbpayment::Client.new(sandbox: true)
  res = client.request(:credit, params)
  pp res
else
  puts 'validation is failed.'
end
