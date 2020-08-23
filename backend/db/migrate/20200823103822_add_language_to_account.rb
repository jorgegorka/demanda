# frozen_string_literal: true

class AddLanguageToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :default_language, :string
  end
end
