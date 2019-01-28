# frozen_string_literal: true

# Groups together folders. Categories can be archived (hidden), and reordered.
class Category < ApplicationRecord
  # Concerns
  include Sluggable
  include Squishable
  squish :name

  # Scopes
  scope :unarchived, -> { where(archived: false) }
  scope :order_by_position, -> { order(Arel.sql("categories.position nulls last")) }
  scope :sidebar, -> { where.not(folders_count: 0).unarchived.order_by_position }

  # Validations
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: true,
                   allow_nil: true

  # Relationships
  has_many :folders, -> { order(Arel.sql("folders.position nulls last")) }, dependent: :destroy
end
