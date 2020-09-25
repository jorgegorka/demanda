# frozen_string_literal: true

class ExtendedInfoFieldsForProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products do |t|
      t.string :slug
      t.string :related_products
    end

    add_index :products, %i[account_id slug]

    change_table :categories do |t|
      t.string :slug
    end

    add_index :categories, %i[account_id slug]
  end
end
