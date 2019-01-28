class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.integer :category_id
      t.string :name
      t.string :slug
      t.text :description
      t.integer :position
      t.boolean :archived, null: false, default: false
      t.timestamps
      t.index [:category_id, :name], unique: true
      t.index [:category_id, :slug], unique: true
      t.index :position
      t.index :archived
    end
  end
end
