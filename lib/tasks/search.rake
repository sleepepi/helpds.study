# frozen_string_literal: true

namespace :search do
  desc "Resets the search index."
  task reset: :environment do
    PgSearch::Document.delete_all
    User.find_each(&:update_pg_search_document)
    Document.find_each(&:update_pg_search_document)
    Site.find_each(&:update_pg_search_document)
    Video.find_each(&:update_pg_search_document)
  end
end
