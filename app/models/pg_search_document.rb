# frozen_string_literal: true

# Add methods to existing PgSearch::Document model.
class PgSearchDocument < PgSearch::Document
  include Searchable

  def self.searchable_attributes
    %w(content)
  end
end
