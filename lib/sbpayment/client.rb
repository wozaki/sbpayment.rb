module Sbpayment
  class Client
    def initialize(sandbox: false)
      @sandbox = sandbox
    end

    def request(method, params, headers = {})
      # TODO handle method
      headers.merge!({'content-type' => 'text/xml'})
      url = @sandbox ? Sbpayment::SANDBOX_URL : Sbpayment::PRODUCTION_URL # TODO consider private environment

      conn = Faraday.new(url: url)
      conn.basic_auth(params.attributes[:merchant_id] + params.attributes[:service_id], params.attributes[:hashkey])

      res = conn.post(Sbpayment::API_PATH, params.to_xml, headers)

      # TODO error handling
      XmlSimple.xml_in res.body
    end
  end
end
