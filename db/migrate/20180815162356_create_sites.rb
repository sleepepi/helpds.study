class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :slug
      t.string :center_type
      t.boolean :archived, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
      t.index :name, unique: true
      t.index :slug, unique: true
      t.index :center_type
      t.index :archived
      t.index :deleted
    end
  end
end
