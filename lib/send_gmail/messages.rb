module SendGmail
  module Messages
    def send_mail(to, subject, msg, from = nil, bcc = nil, cc = nil, user_id = 'me')
      raw_data = SendGmail::Objects::Mail.new(
        to: to,
        subject: subject,
        body: msg,
        from: from,
        bcc: bcc,
        cc: cc
      ).to_raw_data

      parameters = { userId: user_id }

      result = @client.execute!(
        api_method: @gmail_api.users.messages.to_h['gmail.users.messages.send'],
        parameters: parameters,
        body_object: {
          raw: Base64.urlsafe_encode64(raw_data)
        }
      )
      result.status
    end
  end
end
