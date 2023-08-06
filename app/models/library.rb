# frozen_string_literal: true

# Library
class Library < ApplicationRecord
  has_many :books

  validates :name, presence: true
  validates :books_limit, numericality: { only_integer: true, greater_than: 0 }
end
