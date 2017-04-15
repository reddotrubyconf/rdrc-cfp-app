Rails.application.routes.draw do
  root "pages#home"

  namespace :my do
    resources :papers,  only: [:new, :create, :index, :show, :edit, :update]
    resource  :profile, only: [:show, :edit, :update]
  end

  namespace :cleaners do
    resources :papers, only: [:index, :edit, :update]
  end

  namespace :board do
    resources :papers, only: [:index] do
      resources :reviews, only: [:new, :create]
    end
  end

  namespace :organizers do
    resources :papers, only: [:index, :show]
  end

  scope :auth do
    resource :github, only: :none do
      get    :callback, to: "sessions#create"
      get    :new,                              as: "sign_in"
      delete :destroy,  to: "sessions#destroy", as: "sign_out"
    end
  end
end
