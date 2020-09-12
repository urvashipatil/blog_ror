Rails.application.routes.draw do
  resources :categories
  resources :tags
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'  # or root  'home#index' 
  get 'home/ok'
  get 'home/about' , as: :about
  get 'home/contact' , as: :contact
 
end
