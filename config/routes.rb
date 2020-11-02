Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new', as: :signup
    get 'signin', to: 'devise/sessions#new', as: :signin
    post 'signin', to: 'devise/sessions#create'
    delete 'signout', to: 'devise/sessions#destroy', as: :signout
  end
  resources :posts, except: [:edit, :update]
  resources :users, only: [:index, :show]
end
