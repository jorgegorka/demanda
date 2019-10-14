class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name, null: false, default: ''
      t.string :domain
      t.timestamps
    end
  end
end
