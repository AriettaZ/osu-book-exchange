Rails.application.routes.draw do
  get 'dashboard/main'
  get 'dashboard/myorder'
  get 'dashboard/mycontract'
  get 'dashboard/myrequest'
  get 'dashboard/myoffer'
  get 'dashboard/update_account_info'
  get 'dashboard/messages'
  get 'dashboard/bookmarks'
  devise_for :users, path: '', path_names:{edit: 'dashboard/edit', sign_in: 'login', sign_out: 'logout' , sign_up: 'signup'}
  resources :orders
  resources :contracts
  get 'about', to: 'pages#about'
  get 'about-magic', to: 'pages#aboutme'
  get 'contact', to: 'pages#contact'
  resources :books
  resources :posts
  get 'search', to: 'search#search'
  resources :images
  root to: "pages#home"
  resources :messages, except: [:edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
