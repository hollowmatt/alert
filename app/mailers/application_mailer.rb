class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILGUN_MAIL_FROM'] || 'from@example.com'
  layout 'mailer'
end
