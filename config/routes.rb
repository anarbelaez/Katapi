Rails.application.routes.draw do
  root to: 'pages#home', as: :home
  devise_for :users

  # Pages
  get 'activity', to: 'pages#activity'

  # Goals
  resources :goals, shallow: true do
    resources :tasks
  end

  # Users - El nickname es unico para cada usuario
  resources :users, only: %i[show edit update]
  # get 'u/:nickname', to: 'users#show'
end
