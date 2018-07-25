Rails.application.routes.draw do
  root to: "pages#home"
  get 'about', to: 'pages#about'
  get 'about-magic', to: 'pages#aboutme'
  get 'contact_us', to: 'pages#contact_us'
  post 'contact_us', to: 'contact_us#contact_us'
  # user profile pages (and messaging center)
  get 'profile', to: 'dashboard#main', as: 'profile'
  get 'profile/myorder', to: 'dashboard#myorder', as: 'profile_myorder'
  get 'profile/mycontract', to: 'dashboard#mycontract', as: 'profile_mycontract'
  get 'profile/myrequest', to: 'dashboard#myrequest', as: 'profile_myrequest'
  get 'profile/myoffer', to: 'dashboard#myoffer', as: 'profile_myoffer'
  get 'profile/account_information', to: 'dashboard#main', as: 'account_information'
  get 'profile/messages', to: 'dashboard#messages'
  post 'profile/messages', to: 'dashboard#create_message'
  get 'profile/contacts', to: 'dashboard#contacts'
  get 'profile/update_account_info', to: 'dashboard#update_account_info'
  get 'profile/bookmarks', to: 'dashboard#bookmarks', as:"profile_bookmarks"
  # devise user routes
  devise_for :users, path: '', path_names:{edit: 'profile/edit', sign_in: 'login', sign_out: 'logout' , sign_up: 'signup'}
  # resources
  resources :orders
  resources :contracts
  resources :books
  resources :images
  resources :messages, except: [:edit, :update, :destroy]
  # post routes
  get 'posts/new_offer', to: 'posts#new_offer', as: 'posts_new_offer'
  get 'posts/new_request', to: 'posts#new_request', as: 'posts_new_request'
  get 'post/:id/edit_offer', to: 'posts#edit_offer', as: 'post_edit_offer'
  get 'post/:id/edit_request', to: 'posts#edit_request', as: 'post_edit_request'
  get 'posts/admin_index', to: 'posts#admin_index', as: 'posts_admin_index'
  resources :posts, except: [:new,:edit]
  # search routes for finding book exchange listings
  get 'search-book', to: 'books#search'
  get 'search', to: 'search#search'
  # bookmark creation and removal routes
  delete 'bookmarks/:post_id', to: 'bookmarks#destroy'
  post 'bookmarks', to: 'bookmarks#create'
  # AJAX routes to load tables into dashboard/myoffer page
  get 'profile/ajax/a_offer', to: 'ajax_pages#a_offer'
  get 'profile/ajax/p_offer', to: 'ajax_pages#p_offer'
  get 'profile/ajax/c_offer', to: 'ajax_pages#c_offer'
  get 'profile/ajax/d_offer', to: 'ajax_pages#d_offer'
  get 'profile/ajax/a_request', to: 'ajax_pages#a_request'
  get 'profile/ajax/p_request', to: 'ajax_pages#p_request'
  get 'profile/ajax/c_request', to: 'ajax_pages#c_request'
  get 'profile/ajax/d_request', to: 'ajax_pages#d_request'
  get 'profile/ajax/a_order', to: 'ajax_pages#a_order'
  get 'profile/ajax/p_order', to: 'ajax_pages#p_order'
  get 'profile/ajax/cl_order', to: 'ajax_pages#cl_order'
  get 'profile/ajax/ca_order', to: 'ajax_pages#ca_order'
  get 'profile/ajax/u_contract', to: 'ajax_pages#u_contract'
  get 'profile/ajax/w_contract', to: 'ajax_pages#w_contract'
  get 'profile/ajax/c_contract', to: 'ajax_pages#c_contract'
  get 'profile/ajax/d_contract', to: 'ajax_pages#d_contract'
  # AJAX routes to load buyers, sellers options when the admin is creating a contract
  get 'contracts/ajax/buyer', to: 'ajax_pages#buyer'
  get 'ajax/buyer', to: 'ajax_pages#buyer'
  get 'contracts/ajax/seller', to: 'ajax_pages#seller'
  get 'ajax/seller', to: 'ajax_pages#seller'
  get 'contracts/ajax/unsigned', to: 'ajax_pages#unsigned'
  get 'ajax/unsigned', to: 'ajax_pages#unsigned'
  get 'contracts/:id/ajax/buyer', to: 'ajax_pages#buyer'
  get ':id/ajax/buyer', to: 'ajax_pages#buyer'
  get 'contracts/:id/ajax/seller', to: 'ajax_pages#seller'
  get ':id/ajax/seller', to: 'ajax_pages#seller'
  get 'contracts/:id/ajax/unsigned', to: 'ajax_pages#unsigned'
  get ':id/ajax/unsigned', to: 'ajax_pages#unsigned'

  # AJAX routes to load selected contract when admin is createing an order
  get 'orders/ajax/selected_contract', to: 'ajax_pages#selected_contract'
  get 'ajax/selected_contract', to: 'ajax_pages#selected_contract'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
