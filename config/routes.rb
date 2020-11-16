Rails.application.routes.draw do
  root 'posts#index'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  resources :posts, except: %i[edit update] do
    member do
      post 'toggle_favorite', to: 'posts#toggle_favorite'
    end
    resources :comments, only: %i[create destroy show] do
      member do
        post 'toggle_favorite', to: 'comments#toggle_favorite'
      end
    end
  end
  resources :users, only: %i[index show edit update] do
    member do
      get 'friends', to: 'users#friends'
    end
  end
  resources :searches, only: %i[index destroy]
  resources :friendships, only: %i[create destroy]
  resources :notifications, only: [:create]
  get '/search', to: 'searches#search'
  get '/account', to: 'users#account'
  get '/friend_requests', to: 'users#friend_requests'
  get '/friends_search', to: 'users#friends_search'
  get '/notifications', to: 'users#notifications'
end
