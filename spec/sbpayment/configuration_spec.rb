require 'spec_helper'

describe Sbpayment::Configuration do
  describe 'config' do
    it 'returns configuration store' do
      expect(Sbpayment.config).to be_instance_of Sbpayment::Config
    end
  end

  describe '#default_service_id' do
    before do
      Sbpayment.config.service_id = nil # For initialize
    end

    context 'when allow_multiple_service_id is false (default)' do
      before do
        Sbpayment.config.allow_multiple_service_id = false
      end

      context 'when service_id is not given' do
        it 'raises a ConfigurationError' do
          expect{ Sbpayment.config.default_service_id }.to raise_error(Sbpayment::ConfigurationError)
        end
      end

      context 'when service_id is given' do
        before do
          Sbpayment.config.service_id = 'foo'
        end

        it 'returns service_id' do
          expect(Sbpayment.config.default_service_id).to eq 'foo'
        end
      end
    end

    context 'when allow_multiple_service_id is true' do
      before do
        Sbpayment.config.allow_multiple_service_id = true
      end

      it 'returns nil' do
        expect(Sbpayment.config.default_service_id).to be_nil
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
