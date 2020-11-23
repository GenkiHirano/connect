Rails.application.routes.draw do
  get 'users/new'
  get 'users/show'
  get 'users/index'
  root 'static_pages#top'
  get :about, to: 'static_pages#about'
end
