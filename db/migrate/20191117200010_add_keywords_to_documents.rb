class AddKeywordsToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :keywords, :string
  end
end
