Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get 'orders/log'
    post 'orders/confirm', to: 'orders#confirm', as: 'orders_confirm'
    get 'orders/thanx'
    resources :orders, only: [:create, :index, :new, :show]
    # get 'genres', to: 'admin/genres#index', as: :genres
    # get 'genres/:id', to: 'admin/genres#show', as: :genre
    get 'customers/mypage', to: 'customers#show'
    get 'customers/information/edit', to: 'customers#edit'
    patch 'customers/information', to: 'customers#update'
    get 'customers/check'
    patch 'customers/withdraw'
    get 'customers' => "homes#top"
    resources :addresses, only: [:new, :index, :edit, :create, :update, :destroy]
    resources :genres, only: [:index, :show] do # ジャンル毎の商品絞り込みのため追記
      resources :items, only: [:index] #
    end #
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :cart_items, only: [:index, :update, :destroy, :create] do
      collection do
        delete :all_destroy # カートを空にするルート
      end
    end
  end

  namespace :admin do
    root :to =>"homes#top"
    # resources :items
    # resources :customers
    # resources :genres
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
 end
end