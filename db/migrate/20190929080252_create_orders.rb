class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :account
      t.belongs_to :customer
      t.belongs_to :invoice
      t.string :uuid
      t.integer :status
      t.string :customer_reference
      t.timestamps
    end

    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :product
      t.string :uuid
      t.boolean :price_includes_taxes
      t.monetize :price
      t.monetize :quantity
      t.monetize :net_price
      t.monetize :total_tax
      t.monetize :total_discount
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
      t.string :uuid
      t.monetize :amount
      t.monetize :percentage
      t.timestamps
    end
  end
end
