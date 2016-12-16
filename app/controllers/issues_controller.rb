class IssuesController < ApplicationController

	before_action :set_platform
	before_action :set_issue, only: [:show, :edit, :update, :destroy]

	def new
		@issue = @platform.issues.build
	end

	def create
		@issue = @platform.issues.build(issue_params)

		if @issue.save
			flash[:notice] = "Issue has been created."
			redirect_to [@platform, @issue]
		else
			flash.now[:alert] = "Issue has not been created."
			render "new"
		end
	end

	def show
		
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
end