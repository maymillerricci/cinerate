class MoviesList

  def movies_by_genre
    movies_by_genre = {}

    get_genres.each do |genre|
      url = "#{API_BASE_URL}/genre/#{genre["id"]}/movies?api_key=#{API_KEY}"
      raw_data = RestClient.get(url, :accept => :json)
      movies_by_genre[genre["name"]] = JSON.parse(raw_data)["results"]
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

end
