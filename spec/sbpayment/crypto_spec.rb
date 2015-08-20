require 'spec_helper'
require 'sbpayment/crypto'

describe Sbpayment::Crypto do
  let(:key)  { SecureRandom.hex 12 }
  let(:iv)   { SecureRandom.hex  8 }

  describe 'encrypt' do
    let(:data) { 'abcd' }

    it 'can encrypt data' do
      expect(Sbpayment::Crypto.decrypt(Sbpayment::Crypto.encrypt(data, key: key, iv: iv), key: key, iv: iv)).to eq 'abcd'
    end
  end

  describe 'decrypt' do
    let(:data) { Sbpayment::Crypto.encrypt('abcd', key: key, iv: iv) }

    it 'can decrypt encrypted data' do
      expect(Sbpayment::Crypto.decrypt(data, key: key, iv: iv)).to eq 'abcd'
    end

    it 'cannot decrypt encrypted data' do
      expect(Sbpayment::Crypto.decrypt(data, key: SecureRandom.hex(12), iv: SecureRandom.hex(8))).to_not eq 'abcd'
    end
  end
end
