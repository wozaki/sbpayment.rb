require 'spec_helper'
require 'sbpayment/crypto'

describe Sbpayment::Crypto do 
  let(:key)  { SecureRandom.hex }
  let(:iv)   { SecureRandom.hex }

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

    it 'raise error if cannot decrypt' do
      expect { Sbpayment::Crypto.decrypt(data, key: SecureRandom.hex, iv: SecureRandom.hex) }.to raise_error OpenSSL::Cipher::CipherError
    end
  end
end
