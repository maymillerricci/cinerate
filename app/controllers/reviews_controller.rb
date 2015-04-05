class ReviewsController < ApplicationController

  def index

  end

  def new
    @review = Review.new
    @title = params[:movie_title]
  end

  def create
    @review = Review.new(review_params)
    @title ||= params[:review][:movie_title]

    if @review.save
      redirect_to movies_path, notice: "Your movie review has been submitted."
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_email, :rating, :comment, :movie_id, :movie_title)
  end

end
