Rails.application.routes.draw do

  devise_for :users, path_prefix: 'my'
  resources :users do
    member do
      get :orderindex, as: "orders"
    end
  end

  # get 'users/:id/orders', to 'orders#'

  # , :controllers => { registrations: 'registrations' }
  # get 'orders/:id/reset_status', to: 'orders#reset_status', :as => "reset_status"
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products do
    member do
      get :change_active
    end
  end
  resources :product_orders, except: [:index, :show]
  resources :product_orders, only: [:index, :show], param: :week_number
  resources :orders do
    member do
      get :reset_status
    end
  end
  resources :sales, param: :week_number
  resources :customer_orders, only: [:index, :show], param: :week_number

end
