Rails.application.routes.draw do
  resources :teams
  passwordless_for :users , at: '/', as: :auth
  get '/sign_up', :to => "pages#sign_up", :as => :sign_up

  resources :categories
  resources :tallies
  delete '/tallies/:id',  :to => "tallies#destroy", :as => :delete_tally
  # post '/tallies/:id', :to => "tallies#update", :as => :tally
  #
  post '/categories/:id/increment', :to => 'categories#increment', :as => :increment_category
  post '/categories/:id/decrement', :to => 'categories#decrement', :as => :decrement_category

  get '/teams/:id/invite', :to => 'teams#invite', :as => :invite_team
  post '/teams/:id/send',  :to => 'teams#send_invite', :as => :send_invite_team

  # get '/teams/:id/invite/:token', :to => 'teams#accept_invite', :as => :accept_invite_team
  # post '/teams/:id/invite/:token', :to => 'teams#accept_invite', :as => :accept_invite_team

  root 'pages#home'
end
