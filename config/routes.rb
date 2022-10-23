Rails.application.routes.draw do
  root to: 'pages#home', as: :home
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Users
  get 'board', to: 'users#activity', as: :activity

  # Goals
  resources :goals, shallow: true do
    resources :tasks
  end

  get 'goals/category/:category', to: 'goals#by_category', as: :by_category

  # Tasks
  resources :tasks, only: [:index]
  patch '/tasks_update/:id', to: 'tasks#update_task'
  get '/calendar', to: 'tasks#calendar'

  # Users - El nickname es unico para cada usuario
  resources :users, only: %i[show]
  # get 'u/:nickname', to: 'users#show'
end
