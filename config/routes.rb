Rails.application.routes.draw do
  root "papers#new"

  resources :papers, only: [:new, :create, :show]

  scope :auth do
    resource :github, only: :none do
      get    :callback, to: "sessions#create"
      get    :new,                              as: "sign_in"
      delete :destroy,  to: "sessions#destroy", as: "sign_out"
    end
  end
end
