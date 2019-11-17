class AddStaffidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :staffid, :string
  end
end
