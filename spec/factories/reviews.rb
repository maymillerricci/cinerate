FactoryGirl.define do
  factory :review do
    user_email "a@a.com"
    rating 4
    comment "Bad movie!"
    movie_id 82992
    movie_title "Fast & Furious 6"
  end
end
