require 'base64'
require 'digest/sha1'
require 'builder/xmlmarkup'
require_relative 'crypto'

module Sbpayment
  module ParameterDefinition
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def keys
        @keys ||= {}
      end

      def key(name, options={})
        Key.new(name, { position: keys.size + 1 }.merge(options)).tap do |key|
          keys[key.name] = key

          define_method key.rname do
            if instance_variable_defined? key.ivar
              instance_variable_get key.ivar
            else
              instance_variable_set key.ivar, key.default
            end
          end

          define_method key.wname do |value|
            instance_variable_set key.ivar, value
          end
        end
      end

      def many(name, options={})
        key name, { class: Array }.merge(options)
      end

      attr_reader :xml_tag, :xml_attributes

      def tag(name, attributes={})
        @xml_tag = name
        @xml_attributes = attributes
      end
    end

    def initialize(*arg, &blk)
      super
      keys.each_key { |name| read_params name }
    end

    def keys
      self.class.keys
    end

    def attributes
      {}.tap do |hash|
        keys.values.sort_by(&:position).each do |key|
          hash[key.name] = read_params key.name
        end
      end
    end

    def values
      keys.values.reject(&:exclude).sort_by(&:position).flat_map do |key|
        value = read_params key.name
        case
        when key.klass == String
          value
        when key.klass == Array
          value.flat_map(&:values)
        else
          value.values
        end
      end
    end

    def generate_sps_hashcode(encoding: 'Shift_JIS', hashkey: Sbpayment.config.hashkey)
      Digest::SHA1.hexdigest(values.map(&:to_s).map(&:strip).join.encode(encoding) + hashkey)
    end

    def update_sps_hashcode
      write_params :sps_hashcode, generate_sps_hashcode
    end

    def to_sbps_xml(root: true, indent: 2, need_encrypt: false)
      xml = Builder::XmlMarkup.new indent: indent
      xml.instruct! :xml, encoding: 'Shift_JIS' if root
      xml.tag! self.class.xml_tag, (self.class.xml_attributes || {}) do
        keys.values.sort_by(&:position).each do |key|
          value = read_params key.name
          case
          when key.klass == Array
            xml.tag! key.xml_tag do
              value.each do |val|
                xml << val.to_sbps_xml(root: false, indent: indent + 2, need_encrypt: need_encrypt)
              end
            end
          when key.klass == String
            xml.tag! key.xml_tag, key.cast(value, need_encrypt: need_encrypt)
          else
            xml << value.to_sbps_xml(root: false, indent: indent + 2, need_encrypt: need_encrypt)
          end
        end
      end
    end

    def read_params(name)
      __send__ keys.fetch(name.to_s).rname
    end

    def write_params(name, value)
      __send__ keys.fetch(name.to_s).wname, value
    end

    def update_attributes(hash)
      hash.each do |name, value|
        next unless keys.key? name.to_s
        write_params name, value
      end
    end

    class Key
      attr_reader :name, :options, :type, :position, :encrypt, :klass, :exclude, :xml_tag

      def initialize(name, options)
        @name     = name.to_s
        @options  = options
        @type     = @options.fetch :type, :X
        @position = @options.fetch :position, 0
        @encrypt  = @options.fetch :encrypt, false
        @klass    = @options.fetch :class, String
        @xml_tag  = @options.fetch :tag, @name
        @exclude  = @name == 'sps_hashcode'
      end

      def rname
        "#{name}".freeze
      end

      def wname
        "#{name}=".freeze
      end

      def ivar
        "@#{name}".freeze
      end

      def default
        options[:default] && options[:default].is_a?(Proc) ? options[:default].call : options[:default] || klass.new
      end

      def array?
        klass == Array
      end

      def cast(value, need_encrypt: false)
        value = (value || default).to_s
        value = Base64.strict_encode64 value.encode('Shift_JIS') if type == :M
        (need_encrypt && encrypt) ? Base64.strict_encode64(Sbpayment::Crypto.encrypt(value)) : value
      end
    end
  end
end
