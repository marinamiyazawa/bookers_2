Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about', to:'home#about'
  
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show,:index,:edit,:update] do
  	member do
  		get :following, :followers
  	end
  end
  resources :books do
  	resource :book_comments, only: [:create,:destroy]
   resource :favorites, only: [:create, :destroy]
  end

 
  
end