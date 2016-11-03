Rails.application.routes.draw do
  resources :papers, only: [:new, :create, :show]
end
