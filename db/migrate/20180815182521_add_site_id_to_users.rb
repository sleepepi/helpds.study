class AddSiteIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :site_id, :integer
    add_index :users, :site_id
  end
end
