describe "movie reviews" do

  before(:each) do
    genres = '{"genres":[{"id":28,"name":"Action"},{"id":16,"name":"Animation"}]}'
    stub_request(:get, "http://api.themoviedb.org/3/genre/movie/list?api_key=4d5fd42298eee046ace1ea411c3cdb85").
        with(:headers => {'Accept'=>'application/json'}).
        to_return(:status => 200, :body => genres)

    action_movies = '{"id":28,"page":1,"results":[{"adult":false,"backdrop_path":"/qjfE7SkPXpqFs8FX8rIaG6eO2aK.jpg","id":82992,"original_title":"Fast & Furious 6","release_date":"2013-05-24","poster_path":"/kBXgGUt07sLpw6rhpiYwEyOwUDa.jpg","popularity":40.2025233963775,"title":"Fast & Furious 6","video":false,"vote_average":6.6,"vote_count":3574},{"adult":false,"backdrop_path":"/4liSXBZZdURI0c1Id1zLJo6Z3Gu.jpg","id":76757,"original_title":"Jupiter Ascending","release_date":"2015-02-27","poster_path":"/aMEsvTUklw0uZ3gk3Q6lAj6302a.jpg","popularity":25.05051434426,"title":"Jupiter Ascending","video":false,"vote_average":5.7,"vote_count":298},{"adult":false,"backdrop_path":"/sFTXZBtYAPHCwvX6OYNr916M6SZ.jpg","id":260346,"original_title":"Taken 3","release_date":"2014-12-16","poster_path":"/zZHozAJDzVe9oiWUxbnNkDxh5Lc.jpg","popularity":18.767735656315,"title":"Taken 3","video":false,"vote_average":6.4,"vote_count":417}]}'
    stub_request(:get, "http://api.themoviedb.org/3/genre/28/movies?api_key=4d5fd42298eee046ace1ea411c3cdb85").
        with(:headers => {'Accept'=>'application/json'}).
        to_return(:status => 200, :body => action_movies)

    animated_movies = '{"id":16,"page":1,"results":[{"adult":false,"backdrop_path":"/2BXd0t9JdVqCp9sKf6kzMkr7QjB.jpg","id":177572,"original_title":"Big Hero 6","release_date":"2014-11-07","poster_path":"/3zQvuSAUdC3mrx9vnSEpkFX0968.jpg","popularity":18.1554234615675,"title":"Big Hero 6","video":false,"vote_average":8.0,"vote_count":991},{"adult":false,"backdrop_path":"/GtodNrQnorVd3Gv6f6i4bdEwkP.jpg","id":270946,"original_title":"Penguins of Madagascar","release_date":"2014-11-26","poster_path":"/eCdQdoqG9kQQbzPnbVDXqwoTgLl.jpg","popularity":9.67845022227451,"title":"Penguins of Madagascar","video":false,"vote_average":6.7,"vote_count":254}, {"adult":false,"backdrop_path":"/irHmdlkdJphmk4HPfyAQfklKMbY.jpg","id":109445,"original_title":"Frozen","release_date":"2013-11-27","poster_path":"/jIjdFXKUNtdf1bwqMrhearpyjMj.jpg","popularity":4.17501320687209,"title":"Frozen","video":false,"vote_average":7.7,"vote_count":1615}]}'
    stub_request(:get, "http://api.themoviedb.org/3/genre/16/movies?api_key=4d5fd42298eee046ace1ea411c3cdb85").
        with(:headers => {'Accept'=>'application/json'}).
        to_return(:status => 200, :body => animated_movies)
  end

  describe "movies index" do

    describe "movies table" do

      it "should have movies info" do
        visit movies_path

        expect(page).to have_selector("h2", text: "Movies")
        expect(page).to have_selector("tr", text: "Taken 3 2014-12-16 Action")
        expect(page).to have_selector("tr", text: "Big Hero 6 2014-11-07 Animation")
      end

      it "should sort title column", js: true do
        visit movies_path

        find(".tablesorter-header", text: "Title").click # sort ascending
        within("#movies_table") do
          expect(all("tr")[1].all("td")[0].text).to eq("Big Hero 6")
          expect(all("tr")[6].all("td")[0].text).to eq("Taken 3")
        end

        find(".tablesorter-header", text: "Title").click # sort descending
        within("#movies_table") do
          expect(all("tr")[1].all("td")[0].text).to eq("Taken 3")
          expect(all("tr")[6].all("td")[0].text).to eq("Big Hero 6")
        end
      end

      it "should sort release date column", js: true do
        visit movies_path

        find(".tablesorter-header", text: "Release Date").click # sort ascending
        within("#movies_table") do
          expect(all("tr")[1].all("td")[0].text).to eq("Fast & Furious 6")
          expect(all("tr")[1].all("td")[1].text).to eq("2013-05-24")
          expect(all("tr")[6].all("td")[0].text).to eq("Jupiter Ascending")
          expect(all("tr")[6].all("td")[1].text).to eq("2015-02-27")
        end

        find(".tablesorter-header", text: "Release Date").click # sort descending
        within("#movies_table") do
          expect(all("tr")[1].all("td")[0].text).to eq("Jupiter Ascending")
          expect(all("tr")[1].all("td")[1].text).to eq("2015-02-27")
          expect(all("tr")[6].all("td")[0].text).to eq("Fast & Furious 6")
          expect(all("tr")[6].all("td")[1].text).to eq("2013-05-24")
        end
      end

    end

    describe "clicking links" do

      it "should go to all reviews page" do
        visit movies_path
        click_link "Read All Movie Reviews"
        expect(current_path).to eq(reviews_path)
        expect(page).to have_selector("h2", text: "All Movie Reviews")
      end

      it "should go to read reviews for this movie page" do
        visit movies_path
        within("#movies_table") do
          within(all("tr")[1]) do
            click_link "Read Reviews"
          end
        end
        expect(current_path).to eq(movie_path(82992))
        expect(page).to have_selector("h2", text: "Reviews for Fast & Furious 6")
      end

      it "should go to new movie review page" do
        visit movies_path
        within("#movies_table") do
          within(all("tr")[1]) do
            click_link "New Review"
          end
        end
        expect(current_path).to eq(new_movie_review_path(82992))
        expect(page).to have_selector("h2", text: "New Review for Fast & Furious 6")
      end

    end

  end

  describe "create new review" do

    before(:each) do
      visit movies_path
      within("#movies_table") do
        within(all("tr")[1]) do
          click_link "New Review"
        end
      end
    end

    describe "with errors" do

      it "should reload new review page with errors when fields left blank" do
        expect(page).to have_selector("h2", text: "New Review for Fast & Furious 6")
        click_button "Submit Review"
        expect(page).to have_selector("h2", text: "New Review for Fast & Furious 6")
        expect(page).to have_selector(".alert-danger", text: "Please review the problems below:")
        expect(page).to have_selector(".help-block", text: "is not a valid email address")
        expect(page).to have_selector(".help-block", text: "is not a number")
      end

      it "should reload new review page with error when invalid email address" do
        fill_in "Email Address", with: "Name"
        click_button "Submit Review"
        expect(page).to have_selector("h2", text: "New Review for Fast & Furious 6")
        expect(page).to have_selector(".alert-danger", text: "Please review the problems below:")
        expect(page).to have_selector(".help-block", text: "is not a valid email address")
        expect(page).to have_selector(".help-block", text: "is not a number")
      end

    end

    describe "success" do

      before(:each) do
        fill_in "Email Address", with: "email@address.com"
        select "5", from: "Rating"
        fill_in "Comment", with: "decent movie"
        click_button "Submit Review"
      end

      it "should redirect to movies index with success message when submitted" do
        expect(current_path).to eq(movies_path)
        expect(page).to have_selector(".alert-success", text: "Your movie review has been submitted.")
        expect(Review.last.movie_title).to eq("Fast & Furious 6")
      end

      it "should save review to database" do
        expect(Review.last.movie_title).to eq("Fast & Furious 6")
        expect(Review.last.movie_id).to eq(82992)
        expect(Review.last.user_email).to eq("email@address.com")
        expect(Review.last.rating).to eq(5)
        expect(Review.last.comment).to eq("decent movie")
      end

    end

  end

end
