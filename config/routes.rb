Rails.application.routes.draw do
  scope "(:locale)", locale: /en/ do
    resources :brands, only: [:index]
    resources :comments
    resources :statistics
    resources :orders, only: %i[create index]
    resources :categories, only: [:index]
    resources :products, only: %i[index show]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :suggest_search, only: [:index]
    resources :coupons, only: [:index]
    resources :users, only: %i[show update create]
    resources :shops, only: %i[show index]
    resources :search, only: [:index]
    resources :history, only: [:index]
    resources :session, only: %i[create destroy]
    resources :rating, only: [:create, :update]
    resources :rating_shops, only: [:create, :update]
    resources :omni_auth, only: [:create]
    resources :confirm_user, only: [:create]
    resources :recommend_products
    resources :shop_products, only: [:index]
    resources :clothes_care_products, only: [:index]
    resources :electronic_care_products, only: [:index]
    resources :best_seller_products, only: [:index]
    resources :card_payments, only: [:create, :index]
    get 'review_shop' => 'rating_shops#review_shop', :as => 'review_shop'
    get 'sale_products' => 'home_products#sale_products', :as => 'sale_products'
    get 'high_rate_products' => 'home_products#high_rate_products', :as => 'high_rate_products'
    get 'most_buy_products' => 'home_products#most_buy_products', :as => 'most_buy_products'
    require 'sidekiq/web'
    # ...
    mount Sidekiq::Web, at: '/sidekiq'
    # match '/auth/:provider/callback', to: 'omni_auth#create', via: [:get, :post]
    # match 'auth/failure', to: redirect('/'), via: [:get, :post]
  end
end
