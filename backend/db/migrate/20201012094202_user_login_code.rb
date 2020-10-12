class UserLoginCode < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :login_code
      t.datetime :code_created_at
    end

    add_index :users, :login_code
  end
end
