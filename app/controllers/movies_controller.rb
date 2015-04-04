class MoviesController < ApplicationController
  def index
    url = "#{API_BASE_URL}/genre/12/movies?api_key=#{API_KEY}"
    resource = RestClient::Resource.new(url)
    raw_data = resource.get(:accept => :json)
    @movies = JSON.parse(raw_data)["results"]
  end
end
