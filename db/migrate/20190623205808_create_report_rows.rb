class CreateReportRows < ActiveRecord::Migration[6.0]
  def change
    create_table :report_rows do |t|
      t.bigint :report_id
      t.string :label
      t.text :expression
      t.integer :position
      t.jsonb :result
      t.boolean :muted
      t.timestamps

      t.index :report_id
      t.index :position
    end
  end
end
