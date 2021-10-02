class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      # ここでindexページ表示に必要なインスタンス変数を果たさなければいけない
      # だが@bookはもう上で定義されている
      # ↓renderをredirect_to indexにしてもエラーは出ないが、ここで得た
      # @bookが空ですよという情報なしでindexアクションを読み込んでしまうので
      # 空欄のエラー表示がされずにindexに飛んでしまう
      
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    
  end

  def update
    @book = Book.find(params[:id])
    if @book.update()
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
