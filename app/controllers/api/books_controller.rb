# frozen_string_literal: true

# Book Info
class Api::BooksController < ApplicationController
  def details
    library = Library.includes(:books).find(params[:id])
    data = []

    library.books.each do |book|
      book_info = {
        book_name: book.name,
        book_status: book.status
      }
      if book.user_id.present?
        user = User.find(book.user_id)
        book_info[:checked_out_user] = user.name
      end
      data << book_info
    end
    render json: { status: 200, body: data }
  rescue StandardError => e
    render json: { status: 400, body: e.message }    
  end
end
