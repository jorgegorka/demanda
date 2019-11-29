class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :content, null: false, default: 'image'
      t.string :url
      t.string :title
      t.timestamps
    end

    add_index :attachments, %i[attachable_id attachable_type]
  end
end
