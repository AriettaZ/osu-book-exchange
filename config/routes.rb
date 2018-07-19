Rails.application.routes.draw do
  get 'dashboard/myorder'
  get 'dashboard/myrequest'
  get 'dashboard/myoffer'
  get 'dashboard/account_information'
  get 'dashboard/messages'
  get 'dashboard/bookmarks'
  devise_for :users, path: '', path_names:{sign_in: 'login', sign_out: 'logout' , sign_up: 'signup'}
  resources :orders
  resources :contracts
  get 'about', to: 'pages#about'
  get 'about-magic', to: 'pages#aboutme'
  get 'contact', to: 'pages#contact'
  resources :books
  resources :posts, except: [:show]
  get 'post/:id', to: 'posts#show', as: 'post_show'
  root to: "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
