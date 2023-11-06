class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @book = Book.new
    @books = Book.all
    # to = Time.current.at_end_of_day
    # from = (to - 6.day).at_beginning_of_day

    case params[:order]
      when 'favorites'
        @books = Book.select('books.*, COALESCE(COUNT(favorites.id), 0) as favorites_count')
                      .left_outer_joins(:favorites)
                      .group('books.id')
                      .order('favorites_count DESC')
      when 'oldest'
        @books = Book.order(created_at: :asc)
      when 'highest_rated'
        @books = Book.select('books.*, COALESCE(AVG(ratings.value), 0) as average_rating')
                      .left_outer_joins(:ratings)
                      .group('books.id')
                      .order('star DESC, average_rating DESC')
    else
      @books = Book.order(created_at: :desc)
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to @book
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    current_user.read_counts.create(book: @book)
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
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
    params.require(:book).permit(:title, :body, :user_id, :star, :category)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end

end