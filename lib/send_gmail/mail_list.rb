module SendGmail
  module MailList
    def mail_id_list(query, _user_id = 'me', next_page_token = nil)
      parameters = { userId: 'me', q: query }
      parameters[:pageToken] = next_page_token unless next_page_token.nil?

      results = @client.execute!(
        api_method: @gmail_api.users.messages.list,
        parameters: parameters
      )

      {
        mail_id_list: results.data.messages.map(&:id),
        next_page_token: results.data.nextPageToken
      }
    end

    def mail_list(query, user_id = 'me', next_page_token = nil)
      parameters = { userId: 'me', q: query }
      parameters[:pageToken] = next_page_token unless next_page_token.nil?

      results = @client.execute!(
        api_method: @gmail_api.users.messages.list,
        parameters: parameters
      )

      {
        mail_list: results.data.messages.map { |m| mail_detail(m.id, user_id) },
        next_page_token: results.data.nextPageToken
      }
    end

    def mail_detail(mail_id, user_id = 'me')
      results = @client.execute!(
        api_method: @gmail_api.users.messages.get,
        parameters: { userId: user_id, id: mail_id }
      )
      obj = JSON.parse(results.response.body, symbolize_names: true)
      base64url_data = obj[:payload][:body][:data]
      base64url_data ||= obj[:payload][:parts].first[:body][:data]
      base64url_data ||= obj[:payload][:parts].first[:parts].first[:body][:data]
      headers = obj[:payload][:headers]

      mail = SendGmail::Objects::Mail.new
      mail.subject = pickup_contents(headers, 'Subject')
      mail.from = pickup_contents(headers, 'From')
      mail.date = Time.parse(pickup_contents(headers, 'Date'))
      mail.body = Base64.urlsafe_decode64(base64url_data).force_encoding('UTF-8')
      mail
    end

    def pickup_contents(headers, name)
      content = headers.select { |e| e[:name] == name }
      return nil if content.nil?
      return nil if content.first.nil?
      content.first[:value]
    end
  end
end
