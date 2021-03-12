Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :admin do
    namespace :api do
      namespace :v1 do
        namespace :admins do
          mount_devise_token_auth_for 'Admin', at: 'admin_auth', skip: [:registration]
        end
      end
    end
  end

  devise_scope :user do
    namespace :api do
      namespace :v1 do
        namespace :users do
          mount_devise_token_auth_for 'User', at: 'auth'
        end
      end
    end
  end
end
