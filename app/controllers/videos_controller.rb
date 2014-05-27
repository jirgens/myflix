class VideosController < ApplicationController
  before_filter :find_video, only: [:show]

  def index
    @categories = Category.all.order(:name)
  end
    
  def show
  end

  def search
    @results = Video.search_by_title(params[:search])
  end
    
  private

  def find_video
    @video = video.find(params[:id])
  end
end