Rails.application.routes.draw do
  resources :messages
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'
  get 'about', to: 'home#about'
  get 'search', to: 'search#search'
  post 'projects/change_current_project', to: 'projects#change_current_project'

  #get 'registrations/sign_up_params'
  #get 'registrations/account_update_params'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  resources :articles
  resources :projects
  resources :tags, only: [:index, :show]
  resources :comments
  resources :todos
end
