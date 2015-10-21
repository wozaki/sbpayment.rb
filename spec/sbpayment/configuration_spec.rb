require 'spec_helper'
require 'sbpayment/configuration'

describe Sbpayment::Configuration do
  describe 'config' do
    it 'returns configuration store' do
      expect(Sbpayment.config).to be_instance_of Sbpayment::Config
    end
  end

  describe '#default_service_id' do
    context 'when allow_multiple_service_id is true' do
      before do
        Sbpayment.config.allow_multiple_service_id = true
      end

      it 'raises a ConfigrationError' do
        expect{ Sbpayment.config.default_service_id }.to raise_error(Sbpayment::ConfigrationError)
      end
    end

    context 'when allow_multiple_service_id is false (default)' do
      before do
        Sbpayment.config.allow_multiple_service_id = false
        Sbpayment.config.service_id = 'foo'
      end

      it 'returns service_id' do
        expect(Sbpayment.config.default_service_id).to eq 'foo'
      end
    end
  end

  describe 'configure' do
    let(:merchant_id) { SecureRandom.hex }

    before(:example) do
      Sbpayment.configure do |x|
        x.merchant_id = merchant_id
      end
    end

    it 'works' do
      expect(Sbpayment.config.merchant_id).to eq merchant_id
    end
  end
end
