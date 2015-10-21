require 'sbpayment'
require 'cgi'
require 'pry'

Sbpayment.configure do |x|
  x.sandbox = true
  x.merchant_id = '19788'
  x.service_id  = '001'
  x.hashkey = '398a58952baf329cac5efbae97ea84ba17028d02'
end

POST = 'res_payinfo_key=&service_id=001&auto_charge_type=0&free1=&cust_code=498b1fd98ebeb074ff1d50f2e2720a1a&div_settele=0&free3=&res_sps_payment_no=&service_type=0&free2=&sps_hashcode=c27fa2286c6fcc2cef2ce31def31386c2e39783e&order_id=9eb2fced282c5bfc67c2417217ca2682&camp_type=&res_date=20150807161021&amount=980&res_err_code=&last_charge_month=&limit_second=600&pay_type=2&res_payment_date=20150807161021&merchant_id=19788&tracking_id=&res_tracking_id=80312789324671&request_date=20150807161004&pay_item_id=&res_pay_method=&terminal_type=0&res_sps_cust_no=&pay_method=&tax=&item_name=%8Cp%91%B1%89%DB%8B%E0&sps_payment_no=&res_result=OK&item_id=Item+ID&sps_cust_no='
params = POST.encode('Shift_JIS').split('&').map { |e| e.split '=', 2 }.to_h
params.each_value { |value| value.replace CGI.unescape(value) }

report = Sbpayment::Link::PurchaseResult.new
report.update_attributes params, utf8: true
report.validate_sps_hashcode!
pp report.attributes
# {"pay_method"=>"",
 # "merchant_id"=>"19788",
 # "service_id"=>"001",
 # "cust_code"=>"498b1fd98ebeb074ff1d50f2e2720a1a",
 # "sps_cust_no"=>"",
 # "sps_payment_no"=>"",
 # "order_id"=>"9eb2fced282c5bfc67c2417217ca2682",
 # "item_id"=>"Item ID",
 # "pay_item_id"=>"",
 # "item_name"=>"\x{8C70}\x{91B1}\x{89DB}\x{8BE0}",
 # "tax"=>"",
 # "amount"=>"980",
 # "pay_type"=>"2",
 # "auto_charge_type"=>"0",
 # "service_type"=>"0",
 # "div_settele"=>"0",
 # "last_charge_month"=>"",
 # "camp_type"=>"",
 # "tracking_id"=>"",
 # "terminal_type"=>"0",
 # "free1"=>"",
 # "free2"=>"",
 # "free3"=>"",
 # "request_date"=>"20150807161004",
 # "res_pay_method"=>"",
 # "res_result"=>"OK",
 # "res_tracking_id"=>"80312789324671",
 # "res_sps_cust_no"=>"",
 # "res_sps_payment_no"=>"",
 # "res_payinfo_key"=>"",
 # "res_payment_date"=>"20150807161021",
 # "res_err_code"=>"",
 # "res_date"=>"20150807161021",
 # "limit_second"=>"600",
 # "sps_hashcode"=>"c27fa2286c6fcc2cef2ce31def31386c2e39783e"}
