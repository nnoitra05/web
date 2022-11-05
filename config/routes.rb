Rails.application.routes.draw do

  root to: "pages#index"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations"
  }

  resources :boards, only: [:new, :create, :destroy]
  resources :pages, only: [:index] do
    collection do
      get :sandbox
    end
  end
  
end
