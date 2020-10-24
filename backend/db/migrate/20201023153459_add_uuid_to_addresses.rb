class AddUuidToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :uuid, :string , limit: 36, null: false, index: true, unique: true
    rename_column :addresses, :address_1, :first_address
    rename_column :addresses, :address_2, :second_address
  end
end
