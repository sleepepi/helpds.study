class AddDocumentsCountToFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :folders, :documents_count, :integer, null: false, default: 0
  end
end
