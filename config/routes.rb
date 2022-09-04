Rails.application.routes.draw do
  root to: "sentences#index"
  resources :sentences
  resources :entities
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
