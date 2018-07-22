Rails.application.routes.draw do
  get 'dashboard/myorder'
  get 'dashboard/myrequest'
  get 'dashboard/myoffer'
  get 'dashboard/account_information'
  get 'dashboard/messages', to: 'dashboard#messages'
  post 'dashboard/messages', to: 'dashboard#create_message'
  get 'dashboard/contacts', to: 'dashboard#contacts'
  get 'dashboard/bookmarks'
  devise_for :users, path: '', path_names:{sign_in: 'login', sign_out: 'logout' , sign_up: 'signup'}
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
