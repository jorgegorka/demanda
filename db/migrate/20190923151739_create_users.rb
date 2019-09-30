# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :crypted_password
      t.string :salt
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.belongs_to :account
      t.belongs_to :customer
      t.integer :role
      t.timestamps
    end

    add_index :users, %i[email account_id], unique: true
  end
end
