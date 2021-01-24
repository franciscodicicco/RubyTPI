Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  root "home#index"
    resources :users do
        resources :books do
            resources :notes
        end
    end
end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html