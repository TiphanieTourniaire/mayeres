Rails.application.routes.draw do
  devise_for :users

  resource :profile, only: [:show, :edit, :update]
  resources :product_orders, except: [:index, :show]
  resources :product_orders, only: [:index, :show], param: :year_number, as: "date"
  resources :products, only: :index
  get :wait, to: "pages#wait"

  resources :orders do
    member do
      get :reset_status
    end
  end

  namespace :admin do
    resources :posts, only: [:edit, :update]
    resources :subcategories, only: [:index, :edit, :update, :destroy, :create]
    resources :selling_ranges
    resources :products, except: :show do
      member { get :toggle_active }
    end
    resources :categories, only: [] do
      member do
        post '/activate_products', to: 'products#activate_for'
        post '/deactivate_products', to: 'products#deactivate_for'
      end
    end

    resources :users, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
      resources :transactions, only: [:create, :destroy]
      resources :orders, only: [:create]
    end
    resources :orders, only: [:show, :edit, :update, :destroy] do
      resources :product_orders, only: [:create]
    end
    resources :product_orders, except: [:index, :show, :create]
    resources :statistics, only: [:index, :show], param: :year


    root to: 'selling_ranges#index'
  end

  root to: "pages#home"
end
