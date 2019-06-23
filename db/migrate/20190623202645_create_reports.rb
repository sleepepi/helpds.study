class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.bigint :project_id
      t.string :name
      t.string :header_label
      t.jsonb :header
      t.datetime :last_cached_at
      t.boolean :archived, null: false, default: false
      t.boolean :sites_enabled, null: false, default: true
      t.string :report_type
      t.text :filter_expression
      t.text :group_expression
      t.jsonb :data
      t.timestamps

      t.index :project_id
      t.index :archived
    end
  end
end
