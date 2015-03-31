Rails.application.routes.draw do

  namespace :api do
    resources :zoos
  end

end
