class BookmarksController < ApplicationController

  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    @book = @bookmark.book
    if @bookmark.valid?
      @bookmark.save
    end
    render 'bookmarks'
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @book = @bookmark.book
    @bookmark.destroy
    render 'bookmarks'
  end

  private

  def bookmark_params
    params.permit(:book_id)
  end

end
