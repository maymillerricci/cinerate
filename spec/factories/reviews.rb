FactoryGirl.define do

  factory :review do

    factory :review1 do
      user_email "a@a.com"
      rating 1
      comment "Bad movie!"
      movie_id 82992
      movie_title "Fast & Furious 6"
    end

    factory :review2 do
      user_email "b@b.com"
      rating 5
      movie_id 82992
      movie_title "Fast & Furious 6"
    end

    factory :review3 do
      user_email "c@c.com"
      rating 10
      comment "Good movie!"
      movie_id 82992
      movie_title "Fast & Furious 6"
    end

  end

end
