class VideosController < ApplicationController

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if @video.save
      flash[:notice] = "Video was successfully uploaded"
      redirect_to video_path(@video)
    else
      @videos = Video.all
      render :index
    end
  end

  def show
    @video = Video.find(params[:id])
    @videonew = Video.new
  end

  def index
    @videos = Video.all
    @video = Video.new
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      flash[:notice] = "video was successfully updated"
      redirect_to video_path(@video)
    else
      render :index
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path

  end

  private

  def video_params
    params.require(:video).permit(:title, :body, :category, :clip)

  end
end
