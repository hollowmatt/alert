class IssueMailer < ApplicationMailer
  default from: "NOOK Press Alerts <alert@nookeng.com>"
  layout 'mailer'

  def send_email(message)
    @message = message
    mail (to: @message[:to], subject: @message[:subject])
  end
end
