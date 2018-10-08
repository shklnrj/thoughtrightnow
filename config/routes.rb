Rails.application.routes.draw do
  resources :posts
  get 'authenticated/home'
  devise_for :users
  authenticated :user, ->(u) { true } do
    root to: "authenticated#home"
  end  
  root "default#home"
  get 'default/home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
