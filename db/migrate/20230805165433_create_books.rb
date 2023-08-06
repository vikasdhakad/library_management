# frozen_string_literal: true

# Create Books
class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :status, default: 0
      t.integer :user_id
      t.references :library

      t.timestamps
    end
  end
end
