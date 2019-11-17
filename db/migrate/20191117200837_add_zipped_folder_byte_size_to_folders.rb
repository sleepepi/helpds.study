class AddZippedFolderByteSizeToFolders < ActiveRecord::Migration[6.0]
  def change
    add_column :folders, :zipped_folder_byte_size, :bigint, null: false, default: 0
  end
end
