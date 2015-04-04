class MoviesList
  def movies_list_with_genres
    url = "#{API_BASE_URL}/genre/12/movies?api_key=#{API_KEY}"
    resource = RestClient::Resource.new(url)
    raw_data = resource.get(:accept => :json)
    JSON.parse(raw_data)["results"]
  end
end
