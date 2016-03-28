# SendGmail

send_gmail handles gmail.  
now it features only the acquisition of e-mail. this gem is using gmail api.  
https://developers.google.com/gmail/api/ 

## Feature
* create draft
* on/off label
* other...

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'send_gmail'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install send_gmail

## To begin with
```ruby
$ client = SendGmail::Client.new
$ client.authorize(credentials_path, client_id, client_secret, scope)
```

* credentials_path is save authentication information path
* client_id, client_sercret is https://developers.google.com/api-client-library/python/guide/aaa_client_secrets
* scope is https://developers.google.com/gmail/api/auth/scopes

### First Time
1. browser auto open and login user
2. auto write oauth information to credentials_path

### From second time
1. if credentials_path is exist, browser no need to open

## Incoming mail

```ruby
$ mail_id_list = client.mail_id_list(searching_option)
  => {
   :mail_id_list=>["ffffff", "ccccc", ...],
   :next_page_token=>"123456789"
   }

$ mail_id_list[:mail_id_list].map { |mail_id| client.mail_detail(mail_id) }
  => [#<SendGmail::Objects::Mail... , ...]
```

```ruby
$ mail_list = client.mail_list(searching_option)
  => {
   :mail_id_list => [#<SendGmail::Objects::Mail... , ...],
   :next_page_token => "123456789"
   }
```

## Outgoing mail
```ruby
$ client.send_mail(to, subject, msg, from = nil, bcc = nil, cc = nil, user_id = 'me')
  => 200
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hatappi/send_gmail.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

