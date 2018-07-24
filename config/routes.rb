Rails.application.routes.draw do
  get 'profile', to: 'dashboard#main', as: 'profile'
  get 'profile/myorder', to: 'dashboard#myorder', as: 'profile_myorder'
  get 'profile/mycontract', to: 'dashboard#mycontract', as: 'profile_mycontract'
  get 'profile/myrequest', to: 'dashboard#myrequest', as: 'profile_myrequest'
  get 'profile/myoffer', to: 'dashboard#myoffer', as: 'profile_myoffer'
  get 'profile/account_information', to: 'dashboard#account_information', as: 'account_information'
  get 'profile/messages', to: 'dashboard#messages'
  post 'profile/messages', to: 'dashboard#create_message'
  get 'profile/contacts', to: 'dashboard#contacts'

  get 'profile/update_account_info', to: 'dashboard#update_account_info'

  get 'profile/bookmarks', to: 'dashboard#bookmarks', as:"profile_bookmarks"
  devise_for :users, path: '', path_names:{edit: 'profile/edit', sign_in: 'login', sign_out: 'logout' , sign_up: 'signup'}
  resources :orders
  resources :contracts
  get 'about', to: 'pages#about'
  get 'about-magic', to: 'pages#aboutme'
  get 'contact_us', to: 'pages#contact_us'
  post 'contact_us', to: 'contact_us#contact_us'
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
