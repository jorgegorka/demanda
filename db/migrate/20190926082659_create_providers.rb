class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name
      t.belongs_to :account
      t.timestamps
    end
  end
end
