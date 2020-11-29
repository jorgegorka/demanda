# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.belongs_to :account
      t.belongs_to :category
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name
      t.text :description
      t.monetize :price, null: false, default: 0
      t.boolean :price_includes_taxes, default: false
      t.integer :stock, null: false, default: 0
      t.timestamps
    end
  end
end
