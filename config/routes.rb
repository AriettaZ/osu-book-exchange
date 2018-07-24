Rails.application.routes.draw do
  get 'dashboard/main'
  get 'dashboard/myorder'
  get 'dashboard/mycontract'
  get 'dashboard/myrequest'
  get 'dashboard/myoffer'
  get 'dashboard/account_information'
  get 'dashboard/messages', to: 'dashboard#messages'
  post 'dashboard/messages', to: 'dashboard#create_message'
  get 'dashboard/contacts', to: 'dashboard#contacts'

  get 'dashboard/update_account_info'

  get 'dashboard/bookmarks'
  devise_for :users, path: '', path_names:{edit: 'dashboard/edit', sign_in: 'login', sign_out: 'logout' , sign_up: 'signup'}
  resources :orders
  resources :contracts
  get 'about', to: 'pages#about'
  get 'about-magic', to: 'pages#aboutme'
  get 'contact', to: 'pages#contact'
  get 'search-book', to: 'books#search'
  resources :books
  get 'posts/new_offer', to: 'posts#new_offer', as: 'posts_new_offer'
  get 'posts/new_request', to: 'posts#new_request', as: 'posts_new_request'
  get 'post/:id/edit_offer', to: 'posts#edit_offer', as: 'post_edit_offer'
  get 'post/:id/edit_request', to: 'posts#edit_request', as: 'post_edit_request'
  get 'posts/admin_index', to: 'posts#admin_index', as: 'posts_admin_index'
  resources :posts, except: [:new,:edit]
  get 'search', to: 'search#search'
  resources :images
  root to: "pages#home"
  #resources :bookmarks, only: [:create, :destroy]

  delete 'bookmarks/:post_id', to: 'bookmarks#destroy'
  post 'bookmarks', to: 'bookmarks#create'

  resources :messages, except: [:edit, :update, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
