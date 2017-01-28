class Admin::FollowersController < Admin::ApplicationController
  
  before_action :set_follower, only: [:destroy, :show, :update]

  def index
  	@followers = policy_scope(Follower)
  end

  def new
  	@follower = Follower.new
  	authorize @follower, :new?
  end

  def create
  	@follower = Follower.new(follower_params)

  	if @follower.save
  		flash[:notice] = "Follower has been created."
  		redirect_to admin_followers_path
  	else
  		flash.now[:alert] = "Follower has not been created."
  		render "new"
  	end
  end

  def show
  	authorize @follower, :show?
  end

  def update
  	authorize @follower, :update?
  end

  def destroy
  	authorize @follower, :destroy?
  end


  private
	  def follower_params
	    params.require(:follower).permit(:name, :email)
	  end
  	def set_follower
  		@follower = Follower.find(params[:id])
  	end
end
