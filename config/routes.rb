Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about', to:'home#about'

  resources :users, only: [:show,:index,:edit,:update]
  resources :books do
  	resource :book_comments, only: [:create]
   resource :favorites, only: [:create, :destroy]
  end

  delete 'books/:book_id/book_comment/:id', to:'book_comments#destroy', as: 'book_comments'
  
end