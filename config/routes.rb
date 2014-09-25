Rails.application.routes.draw do

  root to: 'loans#index'

  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :categories, only: [:index]
  resources :loans, only: [:show, :index]
  resources :users, only: [:new, :create, :index, :edit, :update]
  resource :account, only: [:show, :edit, :update]
  resource :cart, only: [:show, :update, :destroy]
  resources :contributions, only: [:index, :show, :update] do
    post '/cancel' => 'contributions#cancel', as: :cancel
    post '/delete' => 'contributions#delete_from_cart', as: :delete
    collection do
      post :checkout
      get :review
      get :confirmation
    end
  end

  namespace :borrower do
    get '/' => 'loans#dashboard'

    resources :loans do
      get '/delete_category/:category_id' => 'loans#delete_category', as: :delete_category
      get '/add_category/:category_id' => 'loans#add_category', as: :add_category
      get '/retire' => 'loans#retire', as: :retire
    end

    resources :categories, except: [:show]
end

  get '/code', to: redirect('https://github.com/MarcGarreau/grubhub_v2')
end
