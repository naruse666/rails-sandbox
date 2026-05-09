Rails.application.routes.draw do
  namespace :admin do
    resource :sales_report, only: [:show]
    resources :products, only: %i[index edit update]
  end
  resource :session
  resources :passwords, param: :token
  resources :users, only: %i[index show create]
  resources :products, only: %i[index show]
  resources :registrations, only: %i[new create]

  resource :cart, only: [:show]
  resources :cart_items, only: %i[create update destroy]

  resource :address, only: %i[new create edit update]
  resources :orders, only: %i[index show create] do
    member do
      post :cancel
    end
  end
  resource :checkout, only: %i[new create]
  # Defines the root path route ("/")
  # root 'articles#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :articles do
    resources :comments
  end

  root 'products#index'
end
