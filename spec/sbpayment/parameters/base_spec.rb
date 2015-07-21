require 'spec_helper'

describe Sbpayment::Parameters::Base do
  before do
    @params = {a: 'value1', b: { c: 'value2' }}
  end

  describe '#convert_tosjis' do
    it 'encodes to SHIFT_JIS' do
      klass = Sbpayment::Parameters::Base.new @params
      expect(klass.attributes[:a].encoding).to eq Encoding::SHIFT_JIS
      expect(klass.attributes[:b][:c].encoding).to eq Encoding::SHIFT_JIS
    end
  end

  describe '#build_hashcode' do
    it 'builds hashcode from given params' do
      klass = Sbpayment::Parameters::Base.new @params
      expect(klass.sps_hashcode).to eq '8b47ffd9a8f1360fbf0078c761df063a1c74ccc0'
    end
  end
end
