Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :items, only: [:index, :show, :create, :update, :destroy]
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/merchants', to: 'merchants#show'
      end
      resources :items
      # resources :merchants, only: [:index, :show, :create, :update, :destroy]
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/items', to: 'items#index'
        get '/most_revenue', to: 'business#most_revenue'
        get '/most_items', to: 'business#most_items'
      end
      resources :merchants
    end
  end
end
