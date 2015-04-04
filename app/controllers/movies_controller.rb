class MoviesController < ApplicationController
  def index
    @movies = MoviesList.new.movies_list_with_genres
  end
end
