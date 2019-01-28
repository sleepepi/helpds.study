class AddKeywordsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :keywords, :string
  end
end
