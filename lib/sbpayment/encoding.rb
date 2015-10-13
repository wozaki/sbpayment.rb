module Sbpayment
  module Encoding
    def self.sjis2utf8(str)
      str.force_encoding('Shift_JIS').encode('UTF-8')
    end
  end
end
