class CommentsController < ApplicationController
	before_action :set_issue

	def create
		@comment = @issue.comments.build(comment_params)
		@comment.author = current_user
		authorize @comment, :create?

		if @comment.save
			flash[:notice] = "Comment has been created"
			redirect_to [@issue.platform, @issue]
		else
			flash.now[:alert] = "Comment has not been created"
			@platform = @issue.platform
			render "issues/show"
		end
	end

	private
		def set_issue
			@issue = Issue.find(params[:issue_id])
		end

		def comment_params
			params.require(:comment).permit(:text)
		end
end
