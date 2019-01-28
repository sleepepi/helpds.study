# frozen_string_literal: true

# Generate links to download documents.
module DocumentsHelper
  # This intentionally builds the URL since ActionCable jobs and emails may not
  # know the current request host.
  def document_download_link(document)
    "#{ENV["website_url"]}/docs/#{document.folder.category.to_param}/#{document.folder.to_param}/#{document.filename}"
  end
end
