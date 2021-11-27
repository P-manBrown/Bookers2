class UsersController < ApplicationController

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

  def index
    @book = Book.new
    @users = User.page(params[:page])
    # @users = User.all
    @user = User.find(current_user.id)
  end
  

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
