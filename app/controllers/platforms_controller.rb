class PlatformsController < ApplicationController

  def index
    @platforms = Platform.all
  end

  def new
    @platform = Platform.new
  end

  def create
    @platform = Platform.new(platform_params)

    if @platform.save
      flash[:notice] = "Platform created"
      redirect_to @platform
    else
      #nothing
    end
  end

  def show
    @platform = Platform.find(params[:id])
  end


  private

  def platform_params
    params.require(:platform).permit(:name, :description)
  end

end
