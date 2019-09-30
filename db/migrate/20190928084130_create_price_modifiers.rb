class CreatePriceModifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :price_modifiers do |t|
      t.string :type
      t.belongs_to :account
      t.belongs_to :product
      t.belongs_to :category
      t.belongs_to :customer
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.boolean :active, default: true
      t.boolean :just_once, default: false
      t.string :name
      t.string :code, limit: 30
      t.monetize :percentage
      t.monetize :amount
      t.timestamp :start_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamp :end_at
      t.integer :minimum_quantity, null: false, default: 0
      t.monetize :minimum_price, null: false, default: 0
      t.timestamps
    end

    add_index :price_modifiers, [:id, :type]
    add_index :price_modifiers, [:account_id, :code], unique: true
  end
end
