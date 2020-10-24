class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :addressable_id
      t.string :addressable_type
      t.boolean :invoice, default: false
      t.string :name
      t.string :label
      t.string :vat_number
      t.string :address_1, null: false, default: ''
      t.string :address_2
      t.string :postal_code
      t.string :city, null: false, default: ''
      t.string :state
      t.string :country, null: false, default: ''
      t.timestamps
    end

    add_index :addresses, %i[addressable_id addressable_type]
    add_index :addresses, %i[addressable_id addressable_type invoice], name: 'address_and_invoice'
  end
end
