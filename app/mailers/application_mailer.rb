class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILGUN_USERNAME']
  layout 'mailer'
end
