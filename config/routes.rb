Rails.application.routes.draw do
  passwordless_for :users , at: '/', as: :auth
  resources :categories
  post '/categories/:id/increment', :to => 'categories#increment', :as => :increment_category
  root "categories#index"
end
