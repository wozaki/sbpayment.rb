require 'spec_helper'
require 'sbpayment/configuration'

describe Sbpayment::Configuration do
  describe 'config' do
    it 'returns configuration store' do
      expect(Sbpayment.config).to be_instance_of Sbpayment::Config
    end

    context '#multiple_service_id?' do
      context 'with default mode' do
        it 'returns false' do
          expect(Sbpayment.config.multiple_service_id?).to be(false)
        end
      end
    end

    context '#enable_multiple_service_id' do
      before(:context) do
        Sbpayment.config.enable_multiple_service_id
      end

      it 'enables multiple_service_id mode' do
        expect(Sbpayment.config.multiple_service_id?).to be(true)
      end
    end

    context '#disable_multiple_service_id' do
      before(:context) do
        Sbpayment.config.disable_multiple_service_id
      end

      it 'disables multiple_service_id mode' do
        expect(Sbpayment.config.multiple_service_id?).to be(false)
      end
    end

    context 'when calling service_id without a customized value' do
      context 'with enabled multiple service_id' do
        before(:context) do
          Sbpayment.config.enable_multiple_service_id
        end

        it 'raises a ConfigrationError' do
          expect{ Sbpayment.config.default_service_id }.to raise_error(Sbpayment::ConfigrationError)
        end
      end

      context 'with disabled multiple service_id' do
        before(:context) do
          Sbpayment.config.disable_multiple_service_id
        end

        it 'returns Config#service_id' do
          expect(Sbpayment.config.default_service_id).not_to be_nil
          expect(Sbpayment.config.default_service_id).to equal(Sbpayment.config.service_id)
        end
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
