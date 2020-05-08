class UsersController < ApplicationController
    before_action :authenticate_user!
	before_action :correct_user, only:[:edit]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new 
    
    #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
  	@users = User.all
    if params[:name].present?
      @users = @users.get_by_name params[:name]
    end
  	@book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def search
    @user_or_book = params[:option]
    @how_search = params[:choice]
    
    if @user_or_book =="1"
      @users = User.search(params[:search], @user_or_book)
    else
      @books = Book.search(params[:search], @user_or_book)
    end
  end

end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def correct_user
  @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user)
    end
  end
