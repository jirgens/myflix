class ReviewsController < InheritedResources::Base
  before_filter :require_user
  respond_to :html
  belongs_to :video
  actions :create

  private

  def review_params
    params.require(:review).permit(:rating, :content, :video_id).merge!(user: current_user)
  end
end