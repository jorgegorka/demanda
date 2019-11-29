class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.belongs_to :language
      t.integer :translatable_id
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :translatable_type
      t.string :name
      t.text :description
      t.timestamps
    end

    add_index :translations, %i[translatable_id translatable_type]
  end
end
