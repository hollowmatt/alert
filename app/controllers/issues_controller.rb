class IssuesController < ApplicationController

	before_action :set_platform
	before_action :set_issue, only: [:show, :edit, :update, :destroy, :send_message]
	layout :resolve_layout

	def new
		@issue = @platform.issues.build
		authorize @issue, :create?
	end

	def destroy
		authorize @issue, :destroy?
		@issue.destroy
    flash[:notice] = "Issue has been deleted."
    redirect_to @platform
	end

	def edit
		authorize @issue, :update?
	end

	def update
		authorize @issue, :update?

		if @issue.update(issue_params)
      flash[:notice] = "Issue has been updated."
      redirect_to [@platform, @issue]
    else
      flash.now[:alert] = "Issue has not been updated."
      render "edit"
    end
	end

	def create
		@issue = @platform.issues.build(issue_params)
		@issue.author = current_user
		authorize @issue, :create?

		if @issue.save
			flash[:notice] = "Issue has been created."
			redirect_to [@platform, @issue]
		else
			flash.now[:alert] = "Issue has not been created."
			render "new"
		end
	end

	def show
		authorize @issue, :show?	
	end

	def send_message
		authorize @issue, :update?
		client = Mailgun::Client.new ENV['api_key']
		html_output = render_to_string template: "issue_mailer/send_email"
    message_params = {:from => ENV['username'],
                      :to => @issue.author.email,
                      :subject => build_subject(@platform, @issue),
                      :text => @issue.issue,
                      :html => html_output.to_str
    }
    client.send_message ENV['domain'], message_params
    flash[:notice] = "Message Sent"
		redirect_to [@platform, @issue]
	end

	private
		def set_platform
			@platform = Platform.find(params[:platform_id])
		end

		def set_issue
			@issue = @platform.issues.find(params[:id])
		end

		def issue_params
			params.require(:issue).permit(:priority, :subject, :issue, :impact, :ticket, :status, :next_steps)
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


    def resolve_layout
    	case action_name
    	when "send_message"
    		'mailer'
    	else
    		'application'
    	end
    end

end