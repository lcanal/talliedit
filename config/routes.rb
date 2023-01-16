Rails.application.routes.draw do
  passwordless_for :users , at: '/', as: :auth
  get '/sign_up', :to => "pages#sign_up", :as => :sign_up

  resources :categories
  resources :tallies
  delete '/tallies/:id',  :to => "tallies#destroy", :as => :delete_tally
  # post '/tallies/:id', :to => "tallies#update", :as => :tally
  #
  post '/categories/:id/increment', :to => 'categories#increment', :as => :increment_category
  post '/categories/:id/decrement', :to => 'categories#decrement', :as => :decrement_category
  root 'pages#home'
end
