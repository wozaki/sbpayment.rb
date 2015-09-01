require 'spec_helper'

describe 'Credit API behavior' do
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

  describe 'authorization and commit' do
    around do |e|
      VCR.use_cassette 'authorization-and-commit' do
        e.run
      end
    end

    it 'works' do
      # authorization part

      req = Sbpayment::API::Credit::AuthorizationRequest.new
      req.encrypted_flg = '0'
      req.cust_code = 'Quipper Customer ID'
      req.order_id  = SecureRandom.hex
      req.item_id   = 'item_1'
      req.item_name = 'item'
      req.amount    = 1250

      detail = Sbpayment::API::Credit::AuthorizationRequest::Detail.new
      detail.dtl_rowno      = 1
      detail.dtl_item_id    = 'item_1'
      detail.dtl_item_name  = 'item 1'
      detail.dtl_item_count = 2
      detail.dtl_amount     = 500
      req.dtls << detail

      detail = Sbpayment::API::Credit::AuthorizationRequest::Detail.new
      detail.dtl_rowno      = 2
      detail.dtl_item_id    = 'item_2'
      detail.dtl_item_name  = 'item 2'
      detail.dtl_item_count = 1
      detail.dtl_amount     = 250
      req.dtls << detail

      req.pay_method_info.cc_number = '4242424242424242'
      req.pay_method_info.cc_expiration = '202001'
      req.pay_method_info.security_code = '000'
      req.pay_method_info.dealings_type = 10
      req.pay_option_manage.cust_manage_flg = '1'

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'

      # commit part

      req = Sbpayment::API::Credit::CommitRequest.new
      req.sps_transaction_id  = res.body[:res_sps_transaction_id]
      req.tracking_id         = res.body[:res_tracking_id]
      req.processing_datetime = res.body[:res_process_date]

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'
    end
  end

  describe 'refund' do
    around do |e|
      VCR.use_cassette 'refund' do
        e.run
      end
    end

    it 'works' do
      # authorization part
      req = Sbpayment::API::Credit::AuthorizationRequest.new
      req.encrypted_flg = '0'
      req.cust_code = 'Quipper Customer ID'
      req.order_id  = SecureRandom.hex
      req.item_id   = 'Item ID'
      req.amount    = 1000

      req.pay_method_info.cc_number     = '4242424242424242'
      req.pay_method_info.cc_expiration = '202001'
      req.pay_method_info.security_code = '000'
      req.pay_method_info.dealings_type = 10
      req.pay_option_manage.cust_manage_flg = '1'

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'

      authorization_sps_transaction_id  = res.body[:res_sps_transaction_id]
      authorization_tracking_id         = res.body[:res_tracking_id]
      authorization_processing_datetime = res.body[:res_process_date]

      # inquire part

      req = Sbpayment::API::Credit::InquireAuthorizationRequest.new
      req.encrypted_flg       = '0'
      req.sps_transaction_id  = authorization_sps_transaction_id
      req.tracking_id         = authorization_tracking_id

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'
      expect(res.body[:'res_pay_method_info.res_pay_method_info_detail.cc_number']).to eq '************4242'
      expect(res.body[:'res_pay_method_info.commit_status']).to eq '0'
      expect(res.body[:'res_pay_method_info.payment_status']).to eq '1'

      # commit part

      req = Sbpayment::API::Credit::CommitRequest.new
      req.sps_transaction_id  = authorization_sps_transaction_id
      req.tracking_id         = authorization_tracking_id
      req.processing_datetime = authorization_processing_datetime

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'

      # inquire part

      req = Sbpayment::API::Credit::InquireAuthorizationRequest.new
      req.encrypted_flg       = '0'
      req.sps_transaction_id  = authorization_sps_transaction_id
      req.tracking_id         = authorization_tracking_id

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'
      expect(res.body[:'res_pay_method_info.res_pay_method_info_detail.cc_number']).to eq '************4242'
      expect(res.body[:'res_pay_method_info.commit_status']).to eq '1'
      expect(res.body[:'res_pay_method_info.payment_status']).to eq '1'

      # refund part

      req = Sbpayment::API::Credit::RefundRequest.new
      req.sps_transaction_id  = authorization_sps_transaction_id
      req.tracking_id         = authorization_tracking_id
      req.processing_datetime = authorization_processing_datetime

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'

      # inquire part

      req = Sbpayment::API::Credit::InquireAuthorizationRequest.new
      req.encrypted_flg       = '0'
      req.sps_transaction_id  = authorization_sps_transaction_id
      req.tracking_id         = authorization_tracking_id

      res = req.perform
      expect(res.status).to eq 200
      expect(res.headers['content-type']).to include 'text/xml'
      expect(res.body[:res_result]).to eq 'OK'
      expect(res.body[:'res_pay_method_info.res_pay_method_info_detail.cc_number']).to eq '************4242'
      expect(res.body[:'res_pay_method_info.commit_status']).to eq '1'
      expect(res.body[:'res_pay_method_info.payment_status']).to eq '3'
    end
  end
end
