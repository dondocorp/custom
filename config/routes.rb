Rails.application.routes.draw do
  resources :turns
  resources :batches
  resources :inputs
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  #Turns creation
   post 'turn', to: 'turns#book', as: 'book'
end
