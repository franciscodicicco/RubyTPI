Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  get 'home/index'
  root "home#index"
    resources :users do
        resources :books do
            resources :notes
        end
    end
end