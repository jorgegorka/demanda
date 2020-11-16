# frozen_string_literal: true

class AddCodeToLanguage < ActiveRecord::Migration[6.0]
  def change
    add_column :languages, :code, :string, limit: 6

    add_index :languages, %i[account_id code]
  end
end
