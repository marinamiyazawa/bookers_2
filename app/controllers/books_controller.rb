class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:edit]  
  def show
  	@book1 = Book.find(params[:id])
    @book = Book.new 
    @user = @book1.user
    @book_comment = BookComment.new
  end

  def index
  	@books = Book.all
    @book = Book.new
    @user = current_user #一覧表示するためにBookモデルの情報を全てくださいのall
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
     #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def correct_user
    @book1 = Book.find(params[:id])
    if @book1.user != current_user
      redirect_to books_path
    end
  end

end
