# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to :commentable, polymorphic: { default: 'Product' }
      t.belongs_to :user
      t.belongs_to :language
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :summary
      t.text :description
      t.decimal :rating
      t.boolean :featured, default: false
      t.boolean :verified_purchase, default: false
      t.boolean :approved, default: false
      t.text :reply_description
      t.datetime :replied_at
      t.timestamps
    end

    add_index :comments, %i[commentable_id commentable_type approved language_id], name: :comments_commentable_approved_language
    add_index :comments, %i[featured created_at]
  end
end
