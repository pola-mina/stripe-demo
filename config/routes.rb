Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'Admin', at: 'api/v1/admin_auth', skip: [:registration]
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  devise_scope :admin do
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
