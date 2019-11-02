class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.belongs_to :account
      t.belongs_to :customer
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.monetize :total_tax, null: false, default: 0
      t.monetize :total_discount, null: false, default: 0
      t.monetize :total_gross, null: false, default: 0
      t.monetize :total, null: false, default: 0
      t.timestamps
    end

    create_table :cart_items do |t|
      t.belongs_to :cart
      t.belongs_to :product
      t.monetize :quantity, null: false, default: 0
      t.monetize :price, null: false, default: 0
      t.monetize :total_tax, null: false, default: 0
      t.monetize :total_discount, null: false, default: 0
      t.monetize :total, null: false, default: 0
      t.timestamps
    end
  end
end
