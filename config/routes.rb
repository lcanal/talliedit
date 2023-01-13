Rails.application.routes.draw do
  get 'pages/home'
  passwordless_for :users , at: '/', as: :auth
  resources :categories
  delete '/tallies/:id',  :to => "tallies#destroy", :as => :delete_tally
  post '/categories/:id/increment', :to => 'categories#increment', :as => :increment_category
  # root "categories#index"
  root 'pages#home'
end
