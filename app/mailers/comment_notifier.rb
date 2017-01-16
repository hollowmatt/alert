class CommentNotifier < ApplicationMailer
 def created(comment, user)
    @comment = comment
    @user = user
    @issue = comment.issue
    @platform = @issue.platform

    subject = "SERVICE ALERT: #{@issue.status} | #{@issue.priority} | #{@platform.name}: #{@issue.subject}"
    
    mail(to: user.email, subject: subject)
  end 
end
