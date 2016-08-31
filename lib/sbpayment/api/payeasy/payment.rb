require_relative '../../request'
require_relative '../../response'

module Sbpayment
  module API
    module Payeasy
      class PaymentRequest < Request
        class Detail
          include ParameterDefinition

          tag 'dtl'
          key :dtl_rowno
          key :dtl_item_id
          key :dtl_item_name, type: :M
          key :dtl_item_count
          key :dtl_tax
          key :dtl_amount
        end
        class PayMethodInfo
          include ParameterDefinition

          tag 'pay_method_info'
          key :issue_type,                encrypt: true
          key :last_name,       type: :M, encrypt: true
          key :first_name,      type: :M, encrypt: true
          key :last_name_kana,  type: :M, encrypt: true
          key :first_name_kana, type: :M, encrypt: true
          key :first_zip,                 encrypt: true
          key :second_zip,                encrypt: true
          key :add1,            type: :M, encrypt: true
          key :add2,            type: :M, encrypt: true
          key :add3,            type: :M, encrypt: true
          key :tel,                       encrypt: true
          key :mail,                      encrypt: true
          key :seiyakudate,               encrypt: true
          key :payeasy_type,              encrypt: true
          key :terminal_value,            encrypt: true
          key :pay_csv,                   encrypt: true
          key :bill_info_kana,  type: :M, encrypt: true
          key :bill_info,       type: :M, encrypt: true
          key :bill_note,       type: :M, encrypt: true
          key :bill_date,                 encrypt: true
        end

        tag 'sps-api-request', id: 'ST01-00101-703'
        key :merchant_id, default: -> { Sbpayment.config.merchant_id }
        key :service_id,  default: -> { Sbpayment.config.service_id }
        key :cust_code
        key :order_id
        key :item_id
        key :item_name, type: :M
        key :tax
        key :amount
        key :free1, type: :M
        key :free2, type: :M
        key :free3, type: :M
        key :order_rowno
        many :dtls
        key :pay_method_info, class: PayMethodInfo
        key :encrypted_flg, default: '1'
        key :request_date, default: -> { TimeUtil.format_current_time }
        key :limit_second
        key :sps_hashcode
      end

      class PaymentResponse < Response
        DECRYPT_PARAMETERS = %i(res_pay_method_info.invoice_no
                                res_pay_method_info.bill_date
                                res_pay_method_info.skno
                                res_pay_method_info.cust_number
                                res_pay_method_info.bank_form
                                res_pay_method_info.bptn
                                res_pay_method_info.bill).freeze
      end
    end
  end
end
