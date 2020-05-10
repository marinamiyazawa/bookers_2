class BookCommentsController < ApplicationController
	def create
		@book1 = Book.find(params[:book_id])
		@book_comment = current_user.book_comments.build(book_comment_params)
		@book_comment.book_id = @book1.id
		if @book_comment.save
			 render :index
		 else
		 	@user = @book1.user
		render "/books/show"
		end
	end

	def destroy
		@book_comment = BookComment.find(params[:book_id])
		if @book_comment.user != current_user
         
        else
		   @book_comment.destroy
		   render :index
		end
	end

	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end
