Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :favorite_customer, only: [:index]
      end
      resources :items, only: [:index, :show]
      resources :customers, only: [:index, :show] do
        resources :invoices, only: [:index]
      end
    end
  end
end
