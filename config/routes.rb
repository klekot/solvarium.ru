Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'
  get  'about', to: 'home#about'
  get  'search', to: 'search#search'
  post 'projects/change_current_project', to: 'projects#change_current_project'
  post 'projects/join_project', to: 'projects#join_project'
  post 'projects/leave_project', to: 'projects#leave_project'

  #get 'registrations/sign_up_params'
  #get 'registrations/account_update_params'
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users
  resources :articles
  resources :projects
  resources :tags, only: [:index, :show]
  resources :comments
  resources :todos
  resources :messages
end
