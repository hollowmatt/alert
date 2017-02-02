class Admin::DistlistsController < ApplicationController

  before_action :set_distlist, only: [:destroy, :show, :update]
  skip_after_action :verify_policy_scoped, only: [:index, :platdex]
  def index
    @distlists = Distlist.all
  end

  def new
    @distlist = Distlist.new
    authorize @distlist, :new?
  end

  def create
    @distlist = Distlist.new(distlist_params)
    authorize @distlist, :create?
    if @distlist.save
      flash[:notice] = "#{@distlist.follower.name} has been added to distlist"
      redirect_to admin_distlists_path
    else
      flash.now[:alert] = "Distlist has not been modified"
      render 'new'
    end
  end

  def platdex
    @distlists = Distlist.where(platform_id: params[:id]).order("priority_id asc")
    authorize @distlists, :platdex?
    render "index"
  end

  def show
    authorize @distlist, :show?
  end

  private
    def distlist_params
      params.require(:distlist).permit(:priority_id, :platform_id, :follower_id)
    end

    def set_distlist
      @distlist = Distlist.find(params[:id])
    end
end
