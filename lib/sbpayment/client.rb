module Sbpayment
  class Client
    def initialize(sandbox: false)
      @sandbox = sandbox
    end

    def request(method, params, headers = {})
      headers.merge!({'content-type' => 'text/xml'})
      url = @sandbox ? Sbpayment::SANDBOX_URL : Sbpayment::PRODUCTION_URL # TODO consider private environment

      conn = Faraday.new(url: url)
      conn.basic_auth(params.attributes[:merchant_id] + params.attributes[:service_id], params.attributes[:hashkey])

      path = Sbpayment::API_PATH
      conn.post(path, params.to_xml, headers)
    end
  end
end
