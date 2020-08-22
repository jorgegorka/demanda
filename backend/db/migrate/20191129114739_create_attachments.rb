# frozen_string_literal: true

class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.belongs_to :language, index: true
      t.integer :attachable_id
      t.string :attachable_type
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :title
      t.integer :order, default: 999, index: true
      t.timestamps
    end

    add_index :attachments, %i[attachable_id attachable_type]
  end
end
