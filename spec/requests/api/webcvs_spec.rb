require 'spec_helper'

describe 'Webcvs API behavior' do
  before do
    Sbpayment.configure do |x|
      x.sandbox = true
      x.merchant_id = '30132'
      x.service_id  = '002'
      x.basic_auth_user     = '30132002'
      x.basic_auth_password = '8435dbd48f2249807ec216c3d5ecab714264cc4a'
      x.hashkey = '8435dbd48f2249807ec216c3d5ecab714264cc4a'
    end
  end

  describe 'read payment result' do
    around do |e|
      VCR.use_cassette 'webcvs-read-payment-result' do
        e.run
      end
    end

    xit 'works' do
      # payment part
      req = Sbpayment::API::Webcvs::PaymentRequest.new

      req.cust_code = 'Quipper Customer ID'
      req.order_id  = SecureRandom.hex
      req.item_id   = 'item_1'
      req.item_name = 'item'
      req.amount    = 1250
      req.order_rowno = 1

      detail = Sbpayment::API::Webcvs::PaymentRequest::Detail.new
      detail.dtl_rowno      = 1
      detail.dtl_item_id    = 'item_1'
      detail.dtl_item_name  = 'item 1'
      detail.dtl_item_count = 2
      detail.dtl_amount     = 500
      req.dtls << detail

      detail = Sbpayment::API::Webcvs::PaymentRequest::Detail.new
      detail.dtl_rowno      = 2
      detail.dtl_item_id    = 'item_2'
      detail.dtl_item_name  = 'item 2'
      detail.dtl_item_count = 1
      detail.dtl_amount     = 250
      req.dtls << detail

      req.pay_method_info.issue_type = '0'
      req.pay_method_info.last_name = 'てすと'
      req.pay_method_info.first_name = '　'     # full-width whitespace
      req.pay_method_info.last_name_kana = 'テスト'
      req.pay_method_info.first_name_kana = nil
      req.pay_method_info.first_zip = '000'
      req.pay_method_info.second_zip = '0000'
      req.pay_method_info.add1 = '　'           # full-width whitespace
      req.pay_method_info.add2 = '　'           # full-width whitespace
      req.pay_method_info.add3 = nil
      req.pay_method_info.tel = '0312345678'
      req.pay_method_info.mail = 'cvs@dummy.com'
      req.pay_method_info.seiyakudate = Time.now.strftime('%Y%m%d')
      req.pay_method_info.webcvstype = '001'
      req.pay_method_info.bill_date = Time.now.strftime('%Y%m%d')

      req.encrypted_flg = '0'
      res = req.perform

      # read payment result part
      req = Sbpayment::API::Webcvs::ReadPaymentResultRequest.new
      req.tracking_id = res.body[:res_tracking_id]

      res = req.perform

      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'
      expect(res.body[:res_sps_transaction_id]).to be
      expect(res.body[:res_status]).to be
      expect(res.body[:'res_pay_method_info.webcvstype']).to be
      expect(res.body[:'res_pay_method_info.invoice_no']).to eq '84878807806162'
      expect(res.body[:'res_pay_method_info.bill_date']).to be
      expect(res.body[:'res_pay_method_info.cvs_pay_data1']).to be
      expect(res.body[:'res_pay_method_info.cvs_pay_data2']).to be
      expect(res.body[:'res_pay_method_info.payment_status']).to be
      expect(res.body[:res_process_date]).to be
      expect(res.body[:res_date]).to be
    end
  end
end
