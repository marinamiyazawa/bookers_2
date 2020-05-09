Rails.application.routes.draw do
  get '/search', to: 'search#search'
  devise_for :users
  root 'home#top'
  get 'home/about', to:'home#about'
  
  resources :relationships, only: [:create, :destroy]
  resources :users, only: [:show,:index,:edit,:update] do
  	get :search, on: :collection
  	member do
  		get :following, :followers
  	end
  end
  resources :books do
  	get :search, on: :collection
  	resource :book_comments, only: [:create,:destroy]
   resource :favorites, only: [:create, :destroy]
  end

 
  
end