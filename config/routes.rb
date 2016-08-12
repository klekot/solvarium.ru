Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'
  get 'temp', to: 'home#temp'
  get 'search', to: 'search#search'
  post 'projects/change_current_project', to: 'projects#change_current_project'

  #get 'registrations/sign_up_params'
  #get 'registrations/account_update_params'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  resources :articles
  resources :projects
  resources :tags, except: :new
  resources :comments
end
