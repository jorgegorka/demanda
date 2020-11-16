# frozen_string_literal: true

class AddRatingToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :rating, :integer, default: 0

    add_index :products, %i[account_id rating]
  end
end
