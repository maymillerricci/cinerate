class AddMovieTitleToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :movie_title, :string
  end
end
