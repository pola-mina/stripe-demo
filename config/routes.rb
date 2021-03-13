Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :admin do
    mount_devise_token_auth_for 'Admin', at: 'admin_auth', skip: [:registration]
    namespace :api do
      namespace :v1 do
        namespace :admins do
          resources :products
          resources :services
        end
      end
    end
  end

  devise_scope :user do
    mount_devise_token_auth_for 'User', at: 'auth'
    namespace :api do
      namespace :v1 do
        namespace :users do
          resources :account
          resources :payment_methods
        end
      end
    end
  end
end
