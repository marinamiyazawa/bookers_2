class FavoritesController < ApplicationController

	def create
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: params[:book_id])
		favorite.save
		render 'create.js.erb'
	end

	def destroy
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: params[:book_id])
		favorite.destroy
		render 'destroy.js.erb'
	end
end
