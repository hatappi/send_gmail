require 'mail'
module SendGmail
  module Objects
    class Mail
      attr_accessor :subject, :from, :date, :body, :bcc, :to, :cc

      def initialize(params = {})
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def to_raw_data
        msg = body.to_s
        from_text = from
        to_text = to
        subject_text  = subject

        mail = ::Mail.new do
          from    from_text
          to      to_text
          subject subject_text
          body    msg
        end
        raw = mail.to_s
        raw = "Bcc:#{bcc}\r\n#{raw}" unless bcc.nil?
        raw = "Cc:#{cc}\r\n#{raw}" unless cc.nil?
        raw
      end
    end
  end
end
