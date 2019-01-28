class ChangeSiteIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :site_id, :bigint
  end

  def down
    change_column :users, :site_id, :integer
  end
end
