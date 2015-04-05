Rails.application.routes.draw do
  root "movies#index"
  get "/reviews", to: "reviews#index"
  resources :movies, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end
end
