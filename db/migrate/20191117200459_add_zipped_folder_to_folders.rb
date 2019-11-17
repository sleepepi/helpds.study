class AddZippedFolderToFolders < ActiveRecord::Migration[6.0]
  def change
    add_column :folders, :zipped_folder, :string
  end
end
