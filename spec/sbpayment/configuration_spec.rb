require 'spec_helper'
require 'sbpayment/configuration'

describe Sbpayment::Configuration do 
  describe 'config' do 
    it 'returns configuration store' do 
      expect(Sbpayment.config).to be_instance_of Sbpayment::Config
    end
  end

  describe 'configure' do 
    let(:merchant_id) { SecureRandom.hex }

    before do 
      Sbpayment.configure do |x|
        x.merchant_id = merchant_id
      end
    end

    it 'works' do 
      expect(Sbpayment.config.merchant_id).to eq merchant_id
    end
  end
end
