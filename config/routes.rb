Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :items, only: [:index, :show, :create, :update, :destroy]
      resources :items
      # resources :merchants, only: [:index, :show, :create, :update, :destroy]
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      resources :merchants
    end
  end
end
