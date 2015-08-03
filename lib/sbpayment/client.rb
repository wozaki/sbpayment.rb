module Sbpayment
  class Client
    RETRY_TIMES = 3
    RETRY_INTERVAL = 1
    DEFAULT_HEADERS = { 'content-type' => 'text/xml' }

    def initialize(sandbox: false)
      @sandbox = sandbox
    end

    def request(action, params, headers = {})
      headers.merge! DEFAULT_HEADERS
      url = @sandbox ? Sbpayment::SANDBOX_URL : Sbpayment::PRODUCTION_URL # TODO consider private environment

      conn = Faraday.new(url: url) do |builder|
        builder.request :retry, max: RETRY_TIMES, interval: RETRY_INTERVAL, exceptions: [Errno::ETIMEDOUT, Timeout::Error, Faraday::Error::TimeoutError]
        builder.request :basic_auth, params.attributes[:merchant_id] + params.attributes[:service_id], params.attributes[:hashkey]
        builder.adapter Faraday.default_adapter
      end

      res = conn.post(Sbpayment::API_PATH, params.to_xml, headers)

      # TODO will change to return response class instead of hash
      if res.status == 200
        XmlSimple.xml_in res.body
      else
        puts 'hell yeah' # TODO error handling
      end
    end
  end
end
