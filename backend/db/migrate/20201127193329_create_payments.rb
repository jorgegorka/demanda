# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.belongs_to :order, index: true
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.integer :origin
      t.monetize :total, null: false, default: 0
      t.timestamps
    end
  end
end
