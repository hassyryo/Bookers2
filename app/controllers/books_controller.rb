class BooksController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
    
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
    @user = current_user
  end

  def new
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id)
   flash[:notice] = 'Book was successfully created'
    else
      render :index
    end
  end
  
  def update
    @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end

    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = 'Book was successfully updated'
    else 
      render :edit  
    end
  end
  
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト  
    flash[:notice] = 'Book was successfully destroyed'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, )
  end
end
