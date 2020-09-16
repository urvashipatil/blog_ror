Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :categories
  resources :tags
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'  # or root  'home#index' 
  get 'home/ok'
  get 'home/about' , as: :about
  get 'home/contact' , as: :contact
 
  get 'home/read/:id' , to:'home#read' , as: :post_read

  get 'home/:tag/posts' , to:'home#search_by_tag' , as: :search_by_tag

  # post 'home/search' , as: :home_search  # OR

  get 'home/search' , as: :home_search
end
