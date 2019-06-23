# frozen_string_literal: true

# Tracks position of a report on a page.
class PageReport < ApplicationRecord
  # Relationships
  belongs_to :page
  belongs_to :report
end
