Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :customers do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      namespace :invoice_items do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      namespace :invoices do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      namespace :items do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      namespace :merchants do
        get '/find_all', to: "find#index"
        get '/find', to: "find#show"
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
        resources :favorite_customer, only: [:index]
      end

      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index]
        resources :items, only: [:index]
        resources :invoice_items, only: [:index]
        resources :merchant, only: [:index]
        resources :customer, only: [:index]
      end

      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
        resources :transactions, only: [:index]
      end

      resources :items, only: [:index, :show] do
        resources :invoice_items, only: [:index]
        resources :merchant, only: [:index]
      end

      resources :invoice_items, only: [:index, :show] do
        resources :item, only: [:index]
        resources :invoice, only: [:index]
      end

      resources :transactions do
        resources :invoice, only: [:index]
      end
    end
  end
end
