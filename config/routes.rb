Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#top'
  resources         :users
  get    :signup, to: 'users#new'
  get    :about,  to: 'static_pages#about'
  get    :login,  to: 'sessions#new'
  post   :login,  to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'
end
