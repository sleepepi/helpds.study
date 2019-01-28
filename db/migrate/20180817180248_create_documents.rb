class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.integer :folder_id
      t.string :file
      t.string :filename
      t.string :content_type
      t.bigint :byte_size, null: false, default: 0
      t.integer :download_count, null: false, default: 0
      t.boolean :featured, null: false, default: false
      t.timestamps
      t.index [:folder_id, :filename], unique: true
      t.index :content_type
      t.index :byte_size
      t.index :download_count
      t.index :featured
    end
  end
end
