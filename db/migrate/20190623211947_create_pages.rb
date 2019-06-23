class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :name
      t.string :slug
      t.integer :position
      t.boolean :archived, null: false, default: false
      t.timestamps

      t.index :slug, unique: true
      t.index :archived
    end
  end
end
