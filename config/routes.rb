Rails.application.routes.draw do

  root 'static_pages#home'
  get 'about'   => 'static_pages#about'
  get 'contact'  => 'static_pages#contact'
  get 'signup'  => 'users#new'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signin'  => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'signout' => 'sessions#destroy'
  resources :words
  resources :categories
  resources :lessons
  resources :results
  resources :activities
  namespace :admin do
    root "admin#index"
    resources :users
    resources :categories
    resources :words
  end
end
