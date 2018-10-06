Rails.application.routes.draw do
  resources :users do
    resources :hours
  end
end
