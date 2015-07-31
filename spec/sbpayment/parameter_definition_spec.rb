require 'spec_helper'
require 'sbpayment/parameter_definition'
require 'rexml/document'

describe Sbpayment::ParameterDefinition do 
  class Example
    include Sbpayment::ParameterDefinition

    class Item
      include Sbpayment::ParameterDefinition

      tag 'item'
      key :name, tag: 'itemName'
    end
    class Option
      include Sbpayment::ParameterDefinition

      tag 'opt'
      key :color
    end

    tag 'Examples', attr: 'value'
    key :foo, type: :M
    key :bar, encrypt: true
    key :baz, default: -> { 'default value' }
    many :items
    key :option, class: Option
    key :sps_hashcode
  end

  before do 
    Sbpayment.configure do |x|
      x.cipher_code = SecureRandom.hex
      x.cipher_iv   = SecureRandom.hex
      x.hashkey     = SecureRandom.hex
    end

    @obj = Example.new
    @obj.foo = 'foo'
    @obj.bar = 'bar'
    @obj.items.push Example::Item.new.tap { |i| i.name = 'item a' }
    @obj.items.push Example::Item.new.tap { |i| i.name = 'item b' }
    @obj.option.color = 'red'
    @doc = REXML::Document.new @obj.to_sbps_xml(need_encrypt: true)
  end

  it 'has xml_tag and xml_attributes' do 
    expect(Example.xml_tag).to eq 'Examples'
    expect(Example.xml_attributes).to eq(attr: 'value')
  end

  describe 'to_sbps_xml' do 
    it 'type option' do
      val = REXML::XPath.first(@doc, '/Examples/foo').text
      expect(Base64.strict_decode64(val)).to eq 'foo'
    end

    it 'encrypt option' do
      val = REXML::XPath.first(@doc, '/Examples/bar').text
      expect(Sbpayment::Crypto.decrypt(Base64.strict_decode64(val))).to eq 'bar'
    end

    it 'many' do
      expect(REXML::XPath.match(@doc, '/Examples/items/item').size).to eq 2
    end

    it 'tag option' do
      expect(REXML::XPath.match(@doc, '/Examples/items/item/itemName').map(&:text)).to eq ['item a', 'item b']
    end

    it 'class option' do
      expect(REXML::XPath.first(@doc, '/Examples/opt/color').text).to eq 'red'
    end

    it 'default option' do 
      expect(REXML::XPath.first(@doc, '/Examples/baz').text).to eq 'default value'
    end
  end

  describe 'update_sps_hashcode' do 
    before do
      @obj.update_sps_hashcode
    end

    it 'update sps_hashcode' do 
      expect(@obj.sps_hashcode).to eq Digest::SHA1.hexdigest('foo' + 'bar' + 'default value' + 'item a' + 'item b' + 'red' + Sbpayment.config.hashkey)
    end
  end
end
