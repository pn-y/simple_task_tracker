Rails.application.routes.draw do
  resources :tasks, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
