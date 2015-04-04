class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :user_email
      t.float :rating
      t.string :comment
      t.integer :movie_id

      t.timestamps null: false
    end
  end
end
