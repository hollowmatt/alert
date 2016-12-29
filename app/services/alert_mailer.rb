class AlertMailer
  
  def initialize
  end

  def create_html_message(platform, issue)
    client = get_client
    ac = ActionController::Base.new()
    msg = ""
    html_output = ac.render_to_string template: "issue_mailer/send_email"
    message_params = {:from => ENV['username'],
                      :to => 'hollowmatt@gmail.com',
                      :subject => build_subject(platform, issue),
                      :text => build_body(issue),
                      :html => html_output.to_str
    }
    client.send_message ENV['domain'], message_params
    msg = "Message Sent"
  end

  def create_text_message(issue)

  end

  private
    def get_client
      client = Mailgun::Client.new ENV['api_key']
    end

    def build_subject(platform, issue)
      subject = "SERVICE ALERT: " + issue.status + " | " +
                issue.priority + " | " + platform.name + ": " + 
                issue.subject
    end

    def build_body(issue)
      body = "<h1> SERVICE ALERT</h1>" + 
             "<p>" + issue.issue + "</p>" + 
             "<p>" + issue.impact + "</p>"
    end
end