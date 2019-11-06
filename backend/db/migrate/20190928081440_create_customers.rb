class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.belongs_to :account
      t.belongs_to :language
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name
      t.timestamps
    end
  end
end
