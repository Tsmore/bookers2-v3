class TagsearchesController < ApplicationController

  def search
    @model = Book
    @word = params[:content]
    words = @word.split(/[\s\u3000]+/)
    query = words.map { |word| "category LIKE ?" }.join(' OR ')
    search_terms = words.map { |word| "%#{word}%" }
    @books = Book.where(query, *search_terms)
    render "tagsearches/tagsearch"
  end

end
