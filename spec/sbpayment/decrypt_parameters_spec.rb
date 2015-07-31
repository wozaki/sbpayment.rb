require 'spec_helper'
require 'sbpayment/decrypt_parameters'

describe Sbpayment::DecryptParameters do 
  class Example
    include Sbpayment::DecryptParameters
    DECRYPT_PARAMETERS = %i(foo baz)
  end

  class ExampleWithNoConst
    include Sbpayment::DecryptParameters
  end

  before do 
    Sbpayment.configure do |x|
      x.cipher_code = 'a' * 24
      x.cipher_iv   = 'b' * 8
    end
  end

  it 'returns decrypted hash' do 
    expect(Example.new.decrypt(foo: Sbpayment::Crypto.encrypt('foo', key: 'a' * 24, iv: 'b' * 8),
                               bar: Sbpayment::Crypto.encrypt('bar', key: 'a' * 24, iv: 'b' * 8),
                               baz: Sbpayment::Crypto.encrypt('baz', key: 'a' * 24, iv: 'b' * 8))).to eq(foo: 'foo',
                                                                                                            bar: Sbpayment::Crypto.encrypt('bar', key: 'a' * 24, iv: 'b' * 8),
                                                                                                            baz: 'baz')
  end

  it 'returns hash w/o decrypt' do 
    expect(ExampleWithNoConst.new.decrypt(foo: 'foo',
                                          bar: 'bar',
                                          baz: 'baz')).to eq(foo: 'foo',
                                                             bar: 'bar',
                                                             baz: 'baz')
  end
end
