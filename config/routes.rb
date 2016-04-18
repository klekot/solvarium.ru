Rails.application.routes.draw do
  get 'search', to: 'search#search'

  #get 'registrations/sign_up_params'
  #get 'registrations/account_update_params'
  root 'home#index'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  resources :articles
  resources :projects
end
