class PlatformsController < ApplicationController

  before_filter :current_platform, only: [:edit, :show, :update]

  def index
    @platforms = Platform.all
  end

  def new
    @platform = Platform.new
  end

  def edit
  end

  def update
    if @platform.update(platform_params)
      flash[:notice] = "Platform updated"
      redirect_to @platform
    else
      flash.now[:alert] = "Platform has not been updated."
      render "edit"
    end
  end

  def create
    @platform = Platform.new(platform_params)

    if @platform.save
      flash[:notice] = "Platform created"
      redirect_to @platform
    else
      flash.now[:alert] = "Platform has not been created."
      render "new"
    end
  end

  def show
    @platform = Platform.find(params[:id])
  end


  private

  def platform_params
    params.require(:platform).permit(:name, :description)
  end

  def current_platform
    @platform = Platform.find(params[:id])
  end

end
