Rails.application.routes.draw do
  passwordless_for :users , at: '/', as: :auth
  get '/sign_up', :to => "pages#sign_up", :as => :sign_up

  resources :categories
  resources :tallies
  resources :teams
  resources :memberships

  delete '/tallies/:id',  :to => "tallies#destroy", :as => :delete_tally
  # post '/tallies/:id', :to => "tallies#update", :as => :tally
  #
  post '/categories/:id/increment', :to => 'categories#increment', :as => :increment_category
  post '/categories/:id/decrement', :to => 'categories#decrement', :as => :decrement_category

  get '/teams/:id/invite', :to => 'teams#invite', :as => :invite_team
  post '/teams/:id/send',  :to => 'teams#send_invite', :as => :send_invite_team

  # get '/teams/:id/invite/:token', :to => 'teams#accept_invite', :as => :accept_invite_team
  post '/teams/:id/invite/:token', :to => 'teams#accept_invite', :as => :accept_invite_team


  get '/archived', :to => 'categories#archived', :as => :archived_categories
  post '/archive/:id', :to => 'categories#archive', :as => :archive_category
  post '/restore/:id', :to => 'categories#restore', :as => :restore_category


  root 'pages#home'
end
