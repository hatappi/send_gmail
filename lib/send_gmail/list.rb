module SendGmail
  module List
    def mail_id_list(query, user_id = 'me')
      parameters = { userId: 'me', q: query }

      results = @client.execute!(
        api_method: @gmail_api.users.messages.list,
        parameters: parameters,
      )

      mail_ids = results.data.messages.map(&:id)
    end
  end
end
