class VideosController < InheritedResources::Base
  before_filter :require_user
  actions :show

  def search
    @results = Video.search_by_title(params[:search_term])
  end
  
end