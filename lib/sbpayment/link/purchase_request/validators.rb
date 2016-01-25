class Sbpayment::Link::PurchaseRequest
  FREE_CSV_FIELD_VALIDATOR = Object.new
  class << FREE_CSV_FIELD_VALIDATOR
    NON_ACCEPTABLE_CHARACTER_CODES = [0x2C, 0x27, 0x22, 0x25, 0x7C, 0x26, 0x3C, 0x3E, *(0xA1..0xDF)].freeze

    def valid?(str)
      str.encode(Encoding::SHIFT_JIS).chars.none? { |chr| NON_ACCEPTABLE_CHARACTER_CODES.include? chr.ord }
    end
  end

  FREE_CSV_EMAIL_VALIDATOR = Object.new
  class << FREE_CSV_EMAIL_VALIDATOR
    ACCEPTABLE_CHARACTER_CODES = [*(0x41..0x5A), *(0x61..0x7A), *(0x30..0x39), 0x40, 0x2E, 0x5F, 0x2D].freeze

    def valid?(str)
      str.encode(Encoding::SHIFT_JIS).chars.all? { |chr| ACCEPTABLE_CHARACTER_CODES.include? chr.ord }
    end
  end
end
