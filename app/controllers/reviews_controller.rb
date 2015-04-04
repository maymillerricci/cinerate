class ReviewsController < ApplicationController

  def index

  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to movies_path
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_email, :rating, :comment, :movie_id)
  end

end
