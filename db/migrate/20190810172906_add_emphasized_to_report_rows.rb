class AddEmphasizedToReportRows < ActiveRecord::Migration[6.0]
  def change
    add_column :report_rows, :emphasized, :boolean, null: false, default: false
  end
end
