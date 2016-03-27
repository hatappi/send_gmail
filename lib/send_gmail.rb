require 'google/api_client'
require "send_gmail/version"
require 'send_gmail/auth'
require 'send_gmail/mail_list'
require 'send_gmail/objects/mail'

module SendGmail
  class Client
    include SendGmail::Auth
    include SendGmail::MailList

    attr_accessor :authorization, :client, :gmail_api

    def initialize(app_name='gmail_test', app_ver='ver1.0')
      @client = Google::APIClient.new(application_name: app_name, application_version: app_ver)
      @gmail_api = client.discovered_api('gmail', 'v1')
    end
  end
end
