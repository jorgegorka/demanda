class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name
      t.belongs_to :account
      t.integer :parent_id, null: true, index: true
      t.timestamps
    end
  end
end
