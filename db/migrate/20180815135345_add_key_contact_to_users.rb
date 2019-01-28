class AddKeyContactToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :key_contact, :boolean, null: false, default: false
  end
end
