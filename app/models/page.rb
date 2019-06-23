# frozen_string_literal: true

# Displays a group of reports on a page accessible from the sidebar.
class Page < ApplicationRecord
  # Constants
  ORDERS = {
    "archived" => "pages.archived desc",
    "active" => "pages.archived",
    "position" => "pages.position",
    "position desc" => "pages.position desc",
    "name" => "pages.name",
    "name desc" => "pages.name desc"
  }
  DEFAULT_ORDER = "pages.position nulls last"

  # Concerns
  include Searchable
  def self.searchable_attributes
    %w(name slug)
  end

  include Sluggable

  # Accessors
  attr_accessor :report_hashes

  # Callbacks
  after_save :set_reports

  # Validations
  validates :name, presence: true
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: { case_sensitive: false },
                   allow_nil: true

  # Relationships
  has_many :page_reports, -> { order(Arel.sql("position nulls last")) }
  has_many :reports, through: :page_reports

  # Methods

  private

  def set_reports
    return unless report_hashes&.is_a?(Array)

    page_reports.destroy_all

    report_hashes.each_with_index do |hash, index|
      next if hash[:report_id].blank?

      page_reports.where(
        report_id: hash[:report_id]
      ).first_or_create(position: index)
    end
  end
end
