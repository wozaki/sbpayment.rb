# Supported Actions

## Credit

Action Name  | Japanese | sps-api-request id | Parameter class |
------------- | ------------- | ------------- | ------------- |
`api-credit-authorization` | リアル与信 | `ST01-00111-101` | `Sbpayment::Parameters::Api::Credit::Authorization` |
`api-credit-commit` | コミット (確定処理) | `ST02-00101-101` | `Sbpayment::Parameters::Api::Credit::Commit` |

## Carrier

### Docomo

Action Name  | Japanese | sps-api-request id | Parameter class |
------------- | ------------- | ------------- | ------------- |
`api-docomo-refund` | ドコモケータイ払い 取消・返金要求処理 | `ST02-00303-401` | `Sbpayment::Parameters::Api::Docomo::Refund` |

### au

Action Name  | Japanese | sps-api-request id | Parameter class |
------------- | ------------- | ------------- | ------------- |
`api-au-refund` | auかんたん決済 取消・返金要求処理 | `ST02-00303-402` | `Sbpayment::Parameters::Api::AU::Refund` |

### Softbank

Action Name  | Japanese | sps-api-request id | Parameter class |
------------- | ------------- | ------------- | ------------- |
`api-softbank-authorization` | ソフトバンクまとめて支払い B 継続課金(定期) 要求処理 | `ST01-00104-405` | `Sbpayment::Parameters::Credit::Api::Authorization` |
`api-softbank-commit` | ソフトバンクまとめて支払い B 継続課金(定期) 確定処理 | `ST02-00201-405` | `Sbpayment::Parameters::Credit::Api::Commit` |
`api-softbank-refund` | ソフトバンクまとめて支払い(B)継続課金(定期) 取消返金要求  | `ST02-00303-405` | `Sbpayment::Parameters::Credit::Api::Refund` |
