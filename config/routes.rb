Rails.application.routes.draw do
  root 'static_pages#top'
  resources :live_companions
  resources :relationships, only: [:create, :destroy]
  resources :comments,      only: [:create, :destroy]
  resources :notifications, only: :index
  resources :users do
    member do
      get :following, :followers
    end
  end
  get    :signup,    to: 'users#new'
  get    :about,     to: 'static_pages#about'
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
  get    :favorites, to: 'favorites#index'
  post   "favorites/:live_companion_id/create"  => "favorites#create"
  delete "favorites/:live_companion_id/destroy" => "favorites#destroy"
  post '/static_pages/guest_sign_in', to: 'static_pages#new_guest'
end
