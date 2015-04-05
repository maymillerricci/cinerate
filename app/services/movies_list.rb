class MoviesList

  def movies_by_genre
    movies_by_genre = {}

    get_genres.each do |genre|
      movies_array = get_movies_of_a_genre(genre)
      movies_by_genre[genre["name"]] = movies_array
    end

    # TODO: get rid of duplicate movies (b/c same movie has multiple genres)
    movies_by_genre
  end

  private

  # returns list of genres w/id & name
  def get_genres
    url = "#{API_BASE_URL}/genre/movie/list?api_key=#{API_KEY}"
    api_call(url)["genres"]
  end

  def get_movies_of_a_genre(genre)
    url = "#{API_BASE_URL}/genre/#{genre["id"]}/movies?api_key=#{API_KEY}"
    api_call(url)["results"]
  end

  def api_call(url)
    raw_data = RestClient.get(url, :accept => :json)
    JSON.parse(raw_data)
  end

end
