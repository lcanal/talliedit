Rails.application.routes.draw do
  passwordless_for :users , at: '/', as: :auth
  get '/sign_up', :to => "pages#sign_up"

  resources :categories
  delete '/tallies/:id',  :to => "tallies#destroy", :as => :delete_tally
  post '/categories/:id/increment', :to => 'categories#increment', :as => :increment_category
  root 'pages#home'
end
