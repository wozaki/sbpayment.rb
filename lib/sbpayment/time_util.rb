module Sbpayment
  module TimeUtil
    class << self
      def format_current_time
        in_jst { return ::Time.now.strftime('%Y%m%d%H%M%S') }
      end

      def in_jst
        ENV['TZ'], old = 'Asia/Tokyo', ENV['TZ']
        yield
      ensure
        ENV['TZ'] = old
      end
    end
  end
end
