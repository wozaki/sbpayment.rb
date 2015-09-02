# sbpayment.rb [![Circle CI](https://img.shields.io/circleci/project/quipper/sbpayment.rb.svg)](https://circleci.com/gh/quipper/sbpayment.rb)

A client library for [sbpayment (Softbank Payment Service)](http://www.sbpayment.jp) written in Ruby.

## Installation

TODO: Publish

```ruby
gem 'sbpayment'
```

## Usage

### Supported Actions

Implemented actions are only for what we needed so far. Feel free to add here if you need it.

#### API

##### Credit

Action Name         | sps-api-request id | Request class                                         |
---                 | ---                | ---                                                   |
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

##### Carrier

###### Docomo

Action Name                                      | sps-api-request id | Request class                                     |
---                                              | ---                | ---                                               |
ドコモケータイ払い 取消・返金要求処理 (簡易継続) | `ST02-00303-401`   | `Sbpayment::API::Docomo::SimplifiedRefundRequest` |

###### au

Action Name                       | sps-api-request id | Request class                       |
---                               | ---                | ---                                 |
auかんたん決済 取消・返金要求処理 | `ST02-00303-402`   | `Sbpayment::API::Au::RefundRequest` |

###### Softbank

Action Name                                              | sps-api-request id | Request class                                    |
---                                                      | ---                | ---                                              |
ソフトバンクまとめて支払い B 継続課金(定期) 要求処理     | `ST01-00104-405`   | `Sbpayment::API::Softbank::AuthorizationRequest` |
ソフトバンクまとめて支払い B 継続課金(定期) 確定処理     | `ST02-00201-405`   | `Sbpayment::API::Softbank::CommitRequest`        |
ソフトバンクまとめて支払い(B)継続課金(定期) 取消返金要求 | `ST02-00303-405`   | `Sbpayment::API::Softbank::RefundRequest`        |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/quipper/sbpayment.rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
