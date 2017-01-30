class Admin::DistlistsController < ApplicationController

  before_action :set_distlist, only: [:destroy, :show, :update]
  skip_after_action :verify_policy_scoped, only: [:index]
  def index
    @distlists = Distlist.all
    # authorize Distlist, :index?
  end

  def show
    authorize @distlist, :show?
  end

  private
    def distlist_params
      params.require(:distlist).permit(:priority, :platform, :follower)
    end

    def set_distlist
      @distlist = Distlist.find(params[:id])
    end
end
