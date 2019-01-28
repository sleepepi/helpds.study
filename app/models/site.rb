# frozen_string_literal: true

# Provides information about sites and groups users together.
class Site < ApplicationRecord
  # Constants
  CENTER_TYPES = [
    ["Clinical Coordinating Center", "clinical"],
    ["Data Coordinating Center", "data"],
    ["Recruiting Center", "recruiting"]
  ]
  ORDERS = {
    "name" => "sites.name",
    "name desc" => "sites.name desc",
    "center" => "sites.center_type",
    "center desc" => "sites.center_type desc"
  }
  DEFAULT_ORDER = "sites.name"

  # Concerns
  include Deletable
  include Sluggable
  include Squishable
  squish :name, :slug

  include Searchable
  def self.searchable_attributes
    %w(name slug)
  end

  include PgSearch
  multisearchable against: [:name, :slug, :center_type]

  # Validations
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: true,
                   allow_nil: true
  validates :center_type, inclusion: {
    in: CENTER_TYPES.collect(&:second),
    message: "can't be blank"
  }

  # Relationships
  has_many :users, -> { current.where(approved: true) }

  # Methods

  def center_type_name
    CENTER_TYPES.find { |_name, value| value == center_type }.first
  end
end
