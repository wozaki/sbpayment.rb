require 'spec_helper'

describe Sbpayment::TimeUtil do
  describe '.in_jst' do
    around do |example|
      ENV['TZ'], old = 'UTC', ENV['TZ']
      example.run
      ENV['TZ'] = old
    end

    it do
      expect(Time.now.zone).to eq('UTC')
      described_class.in_jst { expect(Time.now.zone).to eq('JST') }
      expect(Time.now.zone).to eq('UTC')
    end
  end
end
