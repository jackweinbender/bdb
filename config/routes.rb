Rails.application.routes.draw do
  root to: "application#index"
  namespace :api do
    resources :pages
  end
end
