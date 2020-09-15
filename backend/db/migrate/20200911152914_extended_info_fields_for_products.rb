# frozen_string_literal: true

class ExtendedInfoFieldsForProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products do |t|
      t.string :slug
      t.string :meta_title
      t.string :meta_description
      t.text :summary
    end

    add_index :products, %i[account_id slug]

    change_table :categories do |t|
      t.string :slug
      t.string :meta_title
      t.string :meta_description
      t.text :description
      t.text :summary
    end

    add_index :categories, %i[account_id slug]
  end
end
