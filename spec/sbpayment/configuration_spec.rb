require 'spec_helper'

describe Sbpayment::Configuration do
  before do
    # reset Sbpayment::Config.instance for test because it's singleton
    Sbpayment::Config.instance_variable_set('@singleton__instance__', nil)
  end

  describe 'config' do
    it 'returns configuration store' do
      expect(Sbpayment.config).to be_instance_of Sbpayment::Config
    end
  end

  describe 'configure' do
    let(:merchant_id) { SecureRandom.hex }
    let(:service_id)  { 'foo' }

    before do
      Sbpayment.configure do |x|
        x.merchant_id = merchant_id
        x['service_id'] = service_id
      end
    end

    it 'works' do
      expect(Sbpayment.config.merchant_id).to eq merchant_id
      expect(Sbpayment.config.service_id).to eq service_id
    end
  end

  describe '#retry_max_counts' do
    context 'when not changing retry_max_counts' do
      it 'returns default value' do
        expect(Sbpayment.config.retry_max_counts).to eq 3
      end
    end

    context 'when changing retry_max_counts' do
      let(:retry_max_counts)  { 0 }

      before do
        Sbpayment.configure do |x|
          x.retry_max_counts = retry_max_counts
        end
      end

      it 'returns setup value' do
        expect(Sbpayment.config.retry_max_counts).to eq retry_max_counts
      end
    end
  end
end
