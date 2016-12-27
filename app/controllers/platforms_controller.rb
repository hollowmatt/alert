class PlatformsController < ApplicationController

  before_filter :current_platform, only: [:show, :edit, :update]

  def index
    @platforms = policy_scope(Platform)
  end

  def show
    authorize @platform, :show?
  end

  def edit
    authorize @platform, :update?
  end

  def update
    authorize @platform, :update?
    if @platform.update(platform_params)
      flash[:notice] = "Platform has been updated."
      redirect_to @platform
    else
      flash.now[:alert] = "Platform has not been updated."
      render 'edit'
    end
  end

  private

  def platform_params
    params.require(:platform).permit(:name, :description)
  end

  def current_platform
    @platform = Platform.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The platform you were looking for could not be found."
      redirect_to platforms_path
  end

end
