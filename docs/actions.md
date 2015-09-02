# Supported Actions

Implemented actions only for what we needed.

## API

### Credit

Action Name         | sps-api-request id | Request class                                         |
-------------       | -------------      | -------------                                         |
与信要求            | `ST01-00111-101`   | `Sbpayment::API::Credit::AuthorizationRequest`        |
再与信要求          | `ST01-00113-101`   | `Sbpayment::API::Credit::ReAuthorizationRequest`      |
コミット (確定処理) | `ST02-00101-101`   | `Sbpayment::API::Credit::CommitRequest`               |
決済結果参照        | `MG01-00101-101`   | `Sbpayment::API::Credit::InquireAuthorizationRequest` |
取消要求            | `ST02-00305-101`   | `Sbpayment::API::Credit::CancelAuthorizationRequest`  |
返金要求            | `ST02-00303-101`   | `Sbpayment::API::Credit::RefundRequest`               |
部分返金要求        | `ST02-00307-101`   | `Sbpayment::API::Credit::PartlyRefundRequest`         |
顧客情報登録        | `MG02-00101-101`   | `Sbpayment::API::Credit::CreateCustomerRequest`       |
顧客情報更新        | `MG02-00102-101`   | `Sbpayment::API::Credit::UpdateCustomerRequest`       |
顧客情報削除        | `MG02-00103-101`   | `Sbpayment::API::Credit::DeleteCustomerRequest`       |
顧客情報参照        | `MG02-00104-101`   | `Sbpayment::API::Credit::ReadCustomerRequest`         |

### Carrier

#### Docomo

Action Name                                      | sps-api-request id | Request class                                     |
-------------                                    | -------------      | -------------                                     |
ドコモケータイ払い 取消・返金要求処理 (簡易継続) | `ST02-00303-401`   | `Sbpayment::API::Docomo::SimplifiedRefundRequest` |

#### au

Action Name                       | sps-api-request id | Request class                       |
-------------                     | -------------      | -------------                       |
auかんたん決済 取消・返金要求処理 | `ST02-00303-402`   | `Sbpayment::API::Au::RefundRequest` |

#### Softbank

Action Name                                              | sps-api-request id | Request class                                    |
-------------                                            | -------------      | -------------                                    |
ソフトバンクまとめて支払い B 継続課金(定期) 要求処理     | `ST01-00104-405`   | `Sbpayment::API::Softbank::AuthorizationRequest` |
ソフトバンクまとめて支払い B 継続課金(定期) 確定処理     | `ST02-00201-405`   | `Sbpayment::API::Softbank::CommitRequest`        |
ソフトバンクまとめて支払い(B)継続課金(定期) 取消返金要求 | `ST02-00303-405`   | `Sbpayment::API::Softbank::RefundRequest`        |
