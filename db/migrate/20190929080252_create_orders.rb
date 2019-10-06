class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :account
      t.belongs_to :customer
      t.belongs_to :invoice
      t.belongs_to :coupon
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.integer :status
      t.string :customer_reference
      t.monetize :total_tax, null: false, default: 0
      t.monetize :total_discount, null: false, default: 0
      t.timestamps
    end

    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :product
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.boolean :price_includes_taxes
      t.monetize :price, null: false, default: 0
      t.monetize :quantity, null: false, default: 0
      t.monetize :total_tax, null: false, default: 0
      t.monetize :total_discount, null: false, default: 0
      t.string :customer_reference
      t.timestamps
    end

    create_table :order_price_modifiers do |t|
      t.belongs_to :order
      t.belongs_to :order_item
      t.belongs_to :product
      t.belongs_to :category
      t.belongs_to :customer
      t.belongs_to :price_modifier
      t.string :name
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.monetize :amount, null: false, default: 0
      t.monetize :percentage, null: false, default: 0
      t.monetize :minimum_quantity, null: false, default: 0
      t.monetize :minimum_price, null: false, default: 0
      t.timestamps
    end
  end
end
