# frozen_string_literal: true

# Caches a result of a Slice expression for a report row.
class ReportRow < ApplicationRecord
  # Validations
  validates :label, presence: true

  # Relationships
  belongs_to :report
end
