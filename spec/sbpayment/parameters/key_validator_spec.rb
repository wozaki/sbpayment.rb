require 'spec_helper'

describe Sbpayment::Parameters::KeyValidator do 
  class Example
    include Sbpayment::Parameters::KeyValidator
    sbp_key :foo, :bar
    sbp_key 'baz'

    attr_reader :attributes
    def initialize(attributes)
      @attributes = attributes
    end
  end

  class InheritExample < Example
    sbp_key :quz
  end

  it 'records key names' do 
    expect(Example.sbp_keys).to match_array %i(foo bar baz)
  end

  it 'inherit key names from base class' do 
    expect(InheritExample.sbp_keys).to match_array %i(foo bar baz quz)
  end

  describe '#validate_sbp_keys' do 
    it 'returns true' do
      expect(Example.new(foo: 1, bar: 2, baz: 3).validate_sbp_keys).to eq true
    end

    it 'returns false' do
      expect(Example.new(foo: 1, bar: 2).validate_sbp_keys).to eq false
    end

    it 'return true, even string key' do
      expect(Example.new('foo' => 1, 'bar' => 2, 'baz' => 3).validate_sbp_keys).to eq true
    end
  end

  describe '#validate_sbp_keys!' do 
    it 'returns true' do
      expect(Example.new(foo: 1, bar: 2, baz: 3).validate_sbp_keys!).to eq true
    end

    it 'raise error' do
      expect { Example.new(foo: 1, bar: 2).validate_sbp_keys! }.to raise_error Sbpayment::Parameters::KeyNotFoundError
    end
  end
end
