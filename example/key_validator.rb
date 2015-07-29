require 'sbpayment/parameters/key_validator'

class ExampleA
  include Sbpayment::Parameters::KeyValidator

  sbp_key :merchant_id, :service_id, :cust_code
  sbp_key 'pay_method_info.cc_number'

  attr_reader :attributes
  def initialize(attributes={})
    @attributes = attributes
  end
end

class ExampleB < ExampleA
  sbp_key 'pay_method_info.cc_expiration'
end

p ExampleA.sbp_keys
# => [:merchant_id, :service_id, :cust_code, :"pay_method_info.cc_number"]
p ExampleB.sbp_keys
# => [:merchant_id, :service_id, :cust_code, :"pay_method_info.cc_number", :"pay_method_info.cc_expiration"]

a = ExampleA.new(merchant_id: 'a', service_id: 'b')
p a.validate_sbp_keys
# => false
a.attributes[:cust_code] = 'c'
p a.validate_sbp_keys
# => false
a.attributes[:pay_method_info] = {}
p a.validate_sbp_keys
# => false
a.attributes[:pay_method_info][:cc_number] = 'd'
p a.validate_sbp_keys
# => true

b = ExampleB.new(merchant_id: 'a', service_id: 'b', cust_code: 'c', pay_method_info: {})
p b.validate_sbp_keys
# => false
b.attributes[:pay_method_info][:cc_number] = 'd'
b.attributes[:pay_method_info][:cc_expiration] = 'e'
p b.validate_sbp_keys
# => true
