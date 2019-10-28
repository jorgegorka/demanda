class Languages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.belongs_to :account
      t.string :name
      t.string :uuid, limit: 36, null: false, index: true, unique: true
    end

    add_index :languages, %i[account_id name]
  end
end
