class MoviesList

  def movies_by_genre
    movies_by_genre = {}

    get_genres.each do |genre|
      movies_array = get_movies_of_a_genre(genre)
      puts "API"
      movies_by_genre[genre["name"]] = movies_array
    end

    movies_by_genre
  end

  private

  # returns list of genres w/id & name
  def get_genres
    url = "#{API_BASE_URL}/genre/movie/list?api_key=#{API_KEY}"
    raw_data = RestClient.get(url, :accept => :json)
    JSON.parse(raw_data)["genres"]
  end

  def get_movies_of_a_genre(genre)
    url = "#{API_BASE_URL}/genre/#{genre["id"]}/movies?api_key=#{API_KEY}"
    raw_data = RestClient.get(url, :accept => :json)
    JSON.parse(raw_data)["results"]
  end

end
