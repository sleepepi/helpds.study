class ChangeCategoryIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :folders, :category_id, :bigint
  end

  def down
    change_column :folders, :category_id, :integer
  end
end
