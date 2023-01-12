Rails.application.routes.draw do
  resources :categories
  post '/categories/:id/increment', :to => 'categories#increment', :as => :increment_category
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "categories#index"
end
