class ReviewsController < ApplicationController
  before_filter :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.build(review_params)
    if review.save
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      render 'videos/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :video_id).merge!(:user_id => current_user.id)
  end
end