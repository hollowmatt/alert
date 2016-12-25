class PlatformsController < ApplicationController

  before_filter :current_platform, only: [:show]

  def index
    @platforms = Platform.all
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
