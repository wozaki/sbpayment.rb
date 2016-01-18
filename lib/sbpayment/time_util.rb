module Sbpayment
  module TimeUtil
    STRFTIME_FORMAT = '%Y%m%d%H%M%S'.freeze

    class << self
      def format_current_time
        in_jst { return ::Time.now.strftime(STRFTIME_FORMAT) }
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
