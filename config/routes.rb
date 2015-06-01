Rails.application.routes.draw do

  namespace :api do
    resources :zoos
    resources :animals
  end

  get '/api/unicorns' => 'application#unicorns'

end
