class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.integer :position
      t.integer :folders_count, null: false, default: 0
      t.boolean :archived, null: false, default: false
      t.timestamps
      t.index :name, unique: true
      t.index :slug, unique: true
      t.index :position
      t.index :folders_count
      t.index :archived
    end
  end
end
