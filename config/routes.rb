Rails.application.routes.draw do
  root 'static_pages#top'
  resources      :users
  get :signup, to: 'users#new'
  get :about,  to: 'static_pages#about'
end
