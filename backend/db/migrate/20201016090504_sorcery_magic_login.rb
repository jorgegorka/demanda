class SorceryMagicLogin < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :magic_login_token, :string, default: nil
    add_column :users, :magic_login_token_expires_at, :datetime, default: nil
    add_column :users, :magic_login_email_sent_at, :datetime, default: nil

    add_index :users, :magic_login_token
  end
end
