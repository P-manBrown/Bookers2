class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.page(params[:page])
    @user = User.find(current_user.id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save(book_params)
      redirect_to book_path(@book.id), success: 'You have created book successfully.'
    else
      @user = User.find(current_user.id)
      @books = Book.page(params[:page])
      render :index
    end
  end

  def show
    @book_new = Book.new
    @book_find = Book.find(params[:id])
    @user = @book_find.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id == current_user.id
      @book_id = Book.ids
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), success: 'You have update book successfully.'
    else
      @book_id = Book.ids
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private
  def book_params
    params.require(:book).permit(:title, :body, :user_id )
  end

end
