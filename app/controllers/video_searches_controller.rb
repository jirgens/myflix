class VideoSearchesController < ApplicationController
  def create
    @video_search = Video.search_by_title(params[:search_term])
  end
end