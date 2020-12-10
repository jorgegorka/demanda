# frozen_string_literal: true

class CreateOrderLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :order_logs do |t|
      t.belongs_to :order, index: true
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.text :description
      t.timestamps
    end
  end
end
