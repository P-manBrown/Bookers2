class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.page(params[:page])
    @user = User.find(current_user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def show
    @book_new = Book.new
    @book_find = Book.find(params[:id])
    @user = User.find(current_user.id)
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

end
