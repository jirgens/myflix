class Admin::VideosController < AdminsController
  before_filter :require_user

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] =  "You have uploaded the video '#{@video.title}'."
      redirect_to new_admin_video_path
    else
      render :new 
      flash[:error] = "There was a problem with your upload."
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :category_id, :description, :created_at, :updated_at, :large_cover, :small_cover, :video_url)
  end
end