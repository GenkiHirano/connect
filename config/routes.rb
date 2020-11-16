Rails.application.routes.draw do
  root 'static_pages#top'
  get :about, to:'static_pages#about'
end
