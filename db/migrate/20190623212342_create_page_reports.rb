class CreatePageReports < ActiveRecord::Migration[6.0]
  def change
    create_table :page_reports do |t|
      t.bigint :page_id
      t.bigint :report_id
      t.integer :position
      t.timestamps

      t.index [:page_id, :report_id], unique: true
      t.index :position
    end
  end
end
