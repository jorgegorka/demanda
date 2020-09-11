# frozen_string_literal: true

class ExtendedInfoFieldsForProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products do |t|
      t.string :meta_title
      t.string :meta_description
      t.text :summary
    end

    change_table :categories do |t|
      t.string :meta_title
      t.string :meta_description
      t.text :description
      t.text :summary
    end
  end
end
