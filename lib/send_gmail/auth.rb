require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/storage'
require 'google/api_client/auth/storages/file_store'
require 'fileutils'

module SendGmail
  module Auth
    def authorize(
      credentials_path = '/tmp/client_secrets.json',
      client_id = ENV['GOOGLE_CLIENT_ID'],
      client_secret = ENV['GOOGLE_CLIENT_SECRET'],
      scope = 'https://www.googleapis.com/auth/gmail.readonly'
      )
      
      FileUtils.mkdir_p(File.dirname(credentials_path))

      file_store = Google::APIClient::FileStore.new(credentials_path)
      storage = Google::APIClient::Storage.new(file_store)
      auth = storage.authorize

      if auth.nil? || (auth.expired? && auth.refresh_token.nil?)
        flow = Google::APIClient::InstalledAppFlow.new(
          client_id: client_id,
          client_secret: client_secret,
          scope: scope
        )
        auth = flow.authorize(storage)
      end
      @client.authorization = auth
    end
  end
end
