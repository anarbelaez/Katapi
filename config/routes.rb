Rails.application.routes.draw do
  resources :notifications, only: [:index]

  root to: 'pages#home', as: :home
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Users
  get 'board', to: 'users#activity', as: :activity

  get 'get_json', to: 'goals#get_json'

  # Goals
  resources :goals, shallow: true do
    resources :tasks
  end

  get 'goals/category/:category', to: 'goals#by_category', as: :by_category
  get 'goals/status/:maturity', to: 'goals#by_status', as: :by_status
  # Tasks
  get '/tasks', to: 'tasks#all_tasks'
  patch '/tasks_update/:id', to: 'tasks#update_task'
  get '/calendar', to: 'tasks#calendar'
  get '/stats', to: 'tasks#stats'

  # Users - El nickname es unico para cada usuario
  resources :users, only: %i[show]
  # get 'u/:nickname', to: 'users#show'
end
