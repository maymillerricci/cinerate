class MoviesController < ApplicationController

  def index
    @movies_by_genre = MoviesList.new.movies_by_genre
  end

  def show
    @title = params[:movie_title]
    @reviews = Review.where(movie_id: params[:id])
  end

  
end
