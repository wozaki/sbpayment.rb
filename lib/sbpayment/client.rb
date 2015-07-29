module Sbpayment
  class Client
    DEFAULT_HEADERS = { 'content-type' => 'text/xml' }

    def initialize(sandbox: false)
      @sandbox = sandbox
    end

    def request(action, params, headers = {})
      headers.merge! DEFAULT_HEADERS
      url = @sandbox ? Sbpayment::SANDBOX_URL : Sbpayment::PRODUCTION_URL # TODO consider private environment

      conn = Faraday.new(url: url)
      conn.basic_auth(params.attributes[:merchant_id] + params.attributes[:service_id], params.attributes[:hashkey])

      res = conn.post(Sbpayment::API_PATH, params.to_xml, headers)

      # TODO error handling
      XmlSimple.xml_in res.body
    end
  end
end
