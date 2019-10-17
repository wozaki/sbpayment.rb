require 'sbpayment'
require 'pp'
require 'securerandom'

# Credit api request example to exclusive environment (専有環境)

Sbpayment.configure do |x|
  x.sandbox             = true
  x.merchant_id         = ''
  x.service_id          = ''
  x.basic_auth_user     = ''
  x.basic_auth_password = ''
  x.hashkey             = ''
  x.cipher_code         = ''
  x.cipher_iv           = ''
end

req = Sbpayment::API::Credit::AuthorizationRequest.new
req.encrypted_flg = '1'
req.cust_code     = 'Customer ID'
req.order_id      = SecureRandom.hex
req.item_id       = 'item_1'
req.item_name     = 'item'
req.amount        = 1000

detail = Sbpayment::API::Credit::AuthorizationRequest::Detail.new
detail.dtl_rowno      = 1
detail.dtl_item_id    = 'item_1'
detail.dtl_item_name  = 'item 1'
detail.dtl_item_count = 2
detail.dtl_amount     = 500
req.dtls << detail

req.pay_method_info.cc_number         = ''
req.pay_method_info.cc_expiration     = ''
req.pay_method_info.security_code     = ''
req.pay_method_info.dealings_type     = 10
req.pay_option_manage.cust_manage_flg = '1'

res = req.perform
pp res

req = Sbpayment::API::Credit::CommitRequest.new
req.sps_transaction_id  = res.body[:res_sps_transaction_id]
req.tracking_id         = res.body[:res_tracking_id]
req.processing_datetime = res.body[:res_process_date]

res = req.perform
pp res
