module Sbpayment
  class Error < StandardError; end

  # Basicaly used with `APIError.parse(error_code)`
  #  * When given an known `error_code`, this returns as a specific error, that is named as `API12345Error`
  #    * `123` is payment_method code
  #    * `45` is type code
  #    * `item` fields are not used to class name, because they do not necessarily relate to type field
  #  * When given an unknown `error_code`, this returns an `APIUnknownError`
  class APIError < Error
    require_relative 'api_error/definitions'

    PAYMENT_METHOD = nil
    TYPE = nil

    class Field
      class << self
        # @param code [String]
        # @return [self]
        def fetch(code)
          check_code code
          @children[code]
        end

        # @param code [String]
        def valid_code?(code)
          !! self::PATTERN.match(code)
        end

        def check_code(code)
          valid_code?(code) || raise(ArgumentError, "invalid code is given: #{code}")
        end

        private

        def inherited(subclass)
          subclass.class_eval do
            @children = Hash.new { |pool, code| pool[code] = new(code: code) }
          end
        end

        def define_children_from(definitions)
          definitions.each_pair do |code, summary|
            @children[code] = new(code: code, summary: summary)
          end
        end
      end

      attr_reader :code, :summary
      alias_method :to_s, :code

      def initialize(code:, summary: nil)
        self.class.check_code code
        @code = code
        @summary = summary
      end
    end

    class PaymentMethod < Field
      PATTERN = /\A[0-9a-zA-Z]{3}\z/

      define_children_from PAYMENT_METHOD_DEFINITIONS
    end

    class Type < Field
      PATTERN = /\A[0-9a-zA-Z]{2}\z/
    end

    class Item < Field
      PATTERN = /\A[0-9a-zA-Z]{3}\z/
    end

    PATTERN = /\A(?<payment_method>[0-9a-zA-Z]{3})(?<type>[0-9a-zA-Z]{2})(?<item>[0-9a-zA-Z]{3})\z/

    class << self
      # @param res_err_code [String]
      # @return [self]
      def parse(res_err_code)
        if /\A(?<payment_method>[0-9a-zA-Z]{3})(?<type>[0-9a-zA-Z]{2})(?<item>[0-9a-zA-Z]{3})\z/ =~ res_err_code
          class_name = :"API#{payment_method}#{type}Error"
          if Sbpayment.const_defined? class_name
            klass = Sbpayment.const_get class_name
            klass.new item: klass::Item.fetch(item)
          else
            APIUnknownError.new payment_method: PaymentMethod.fetch(payment_method), type: Type.fetch(type), item: Item.fetch(item)
          end
        else
          raise ArgumentError, "given an invalid format: #{res_err_code}"
        end
      end

      # @return [PaymentMethod]
      def payment_method
        self::PAYMENT_METHOD
      end

      # @return [Type]
      def type
        self::TYPE
      end
    end

    attr_reader :item

    def initialize(error_message=nil, item:)
      super error_message
      @item = item
    end

    # @return [PaymentMethod]
    def payment_method
      self.class.payment_method
    end

    # @return [Type]
    def type
      self.class.type
    end

    # @return [String]
    def res_err_code
      str = "#{payment_method.code}#{type.code}#{@item.code}"
      PATTERN.match(str) ? str : raise("should not reach here: #{str}")
    end
    alias_method :to_s, :res_err_code

    # @return [String]
    def summary
      "method: #{payment_method.code}(#{payment_method.summary}), type: #{type.code}(#{type.summary}), item: #{@item.code}(#{@item.summary})"
    end

    def inspect
      "#{super}: #{summary}"
    end
  end

  class APIUnknownError < APIError
    def initialize(error_message=nil, item:, payment_method:, type:)
      super error_message, item: item
      @payment_method = payment_method
      @type = type
    end

    attr_reader :payment_method, :type
  end

  APIError::PAYMENT_METHOD_DEFINITIONS.each_pair do |code, summary|
    klass = Class.new(APIError) do
      self::PAYMENT_METHOD = APIError::PaymentMethod.new(code: code, summary: summary)
    end

    const_set :"API#{code}Error", klass
  end

  APIError::TYPE_DEFINITIONS.each_pair do |payment_method_code, definitions|
    definitions.each_pair do |type_code, summary|
      klass = Class.new(const_get :"API#{payment_method_code}Error") do
        self::TYPE = APIError::Type.new(code: type_code, summary: summary)
      end

      const_set :"API#{payment_method_code}#{type_code}Error", klass
    end
  end

  APIError::ITEM_DEFINITIONS.each_pair do |payment_method_code, definitions|
    const_get(:"API#{payment_method_code}Error").class_eval do
      klass = Class.new(APIError::Item) do
        define_children_from definitions
      end

      const_set :Item, klass
    end
  end
end
