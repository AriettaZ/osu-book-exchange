Rails.application.routes.draw do
  resources :orders
  resources :contracts
  devise_for :users, path: '', path_names:{sign_in: 'login', sign_out: 'logout' , sign_up: 'signup'}
  get 'aboutme', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  resources :books
  resources :posts, except: [:show]
  get 'post/:id', to: 'posts#show', as: 'post_show'
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
