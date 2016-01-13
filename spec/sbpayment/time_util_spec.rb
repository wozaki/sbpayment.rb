require 'spec_helper'

describe Sbpayment::TimeUtil do
  around do |example|
    ENV['TZ'], old = 'UTC', ENV['TZ']
    example.run
    ENV['TZ'] = old
  end

  describe '.format_current_time' do
    subject { described_class.format_current_time }

    it { is_expected.to eq((Time.now + 9 * 60 * 60).strftime Sbpayment::TimeUtil::STRFTIME_FORMAT) } # TODO Consider to use `timecop` for stable results
  end

  describe '.in_jst' do
    it do
      expect(Time.now.zone).to eq('UTC')
      described_class.in_jst { expect(Time.now.zone).to eq('JST') }
      expect(Time.now.zone).to eq('UTC')
    end
  end
end
