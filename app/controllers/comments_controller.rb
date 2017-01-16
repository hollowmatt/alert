class CommentsController < ApplicationController
	before_action :set_issue

	def create
		@creator = CommentCreator.build(@issue.comments, current_user, comment_params)
		authorize @creator.comment, :create?

		if @creator.save
			flash[:notice] = "Comment has been created"
			redirect_to [@issue.platform, @issue]
		else
			flash.now[:alert] = "Comment has not been created"
			@platform = @issue.platform
			@comment = @creator.comment
			render "issues/show"
		end
	end

	private
		def set_issue
			@issue = Issue.find(params[:issue_id])
		end

		def comment_params
			params.require(:comment).permit(:text, :status_id)
		end
end
