class ChangeFolderIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :documents, :folder_id, :bigint
  end

  def down
    change_column :documents, :folder_id, :integer
  end
end
