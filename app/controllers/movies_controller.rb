class MoviesController < ApplicationController
  def index
    @movies_by_genre = MoviesList.new.movies_by_genre
  end
end
