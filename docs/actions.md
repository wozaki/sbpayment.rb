# Supported Actions

Implemented actions only for what we needed.

## API

### Credit

Action Name         | sps-api-request id | Request class                                         |
-------------       | -------------      | -------------                                         |
与信要求            | `ST01-00111-101`   | `Sbpayment::Api::Credit::AuthorizationRequest`        |
再与信要求          | `ST01-00113-101`   | `Sbpayment::Api::Credit::ReAuthorizationRequest`      |
コミット (確定処理) | `ST02-00101-101`   | `Sbpayment::Api::Credit::CommitRequest`               |
決済結果参照        | `MG01-00101-101`   | `Sbpayment::Api::Credit::InquireAuthorizationRequest` |
取消要求            | `ST02-00305-101`   | `Sbpayment::Api::Credit::CancelAuthorizationRequest`  |
返金要求            | `ST02-00303-101`   | `Sbpayment::Api::Credit::RefundRequest`               |
部分返金要求        | `ST02-00307-101`   | `Sbpayment::Api::Credit::PartlyRefundRequest`         |
顧客情報登録        | `MG02-00101-101`   | `Sbpayment::Api::Credit::CreateCustomerRequest`       |
顧客情報参照        | `MG02-00104-101`   | `Sbpayment::Api::Credit::ReadCustomerRequest`         |
顧客情報更新        | `MG02-00102-101`   | `Sbpayment::Api::Credit::UpdateCustomerRequest`       |
顧客情報削除        | `MG02-00103-101`   | `Sbpayment::Api::Credit::DeleteCustomerRequest`       |

### Carrier

#### Docomo

Action Name                           | sps-api-request id | Request class |
-------------                         | -------------      | ------------- |
ドコモケータイ払い 取消・返金要求処理 | `ST02-00303-401`   | ``            |

#### au

Action Name                       | sps-api-request id | Request class |
-------------                     | -------------      | ------------- |
auかんたん決済 取消・返金要求処理 | `ST02-00303-402`   | ``            |

#### Softbank

Action Name                                              | sps-api-request id | Request class |
-------------                                            | -------------      | ------------- |
ソフトバンクまとめて支払い B 継続課金(定期) 要求処理     | `ST01-00104-405`   | ``            |
ソフトバンクまとめて支払い B 継続課金(定期) 確定処理     | `ST02-00201-405`   | ``            |
ソフトバンクまとめて支払い(B)継続課金(定期) 取消返金要求 | `ST02-00303-405`   | ``            |
