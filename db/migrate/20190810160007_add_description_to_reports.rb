class AddDescriptionToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :description, :text
  end
end
