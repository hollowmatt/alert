class Admin::PlatformsController < Admin::ApplicationController

  before_filter :current_platform, only: [:destroy, :update, :edit]

  def new
    @platform = Platform.new
  end

  def destroy
    @platform.destroy
    flash[:notice] = "Platform has been deleted."
    redirect_to platforms_path
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
