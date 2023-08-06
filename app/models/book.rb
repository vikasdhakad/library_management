# frozen_string_literal: true

# Book
class Book < ApplicationRecord
  belongs_to :library

  enum status: %w[available checkout]

  validates :name, :status, presence:true
  validates :status, inclusion: { in: %w[available checkout] }
  validate :validate_book_limit, on: :create

  def assign_user(user)
    update_columns(user_id: user.id, status: 1)
  end

  private

  def validate_book_limit
    current_library = library
    if current_library.books.size >= current_library.books_limit
      errors.add(:base, "Exceeded maximum allowed books for #{current_library.name} library")
    end
  end
end
