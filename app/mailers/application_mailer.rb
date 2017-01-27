class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILGUN_MAIL_FROM']
  layout 'mailer'
end
