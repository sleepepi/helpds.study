# frozen_string_literal: true

# Embeds link to video.
class Video < ApplicationRecord
  # Constants
  ORDERS = {
    "oldest" => "videos.created_at",
    "latest" => "videos.created_at desc",
    "name desc" => "videos.name desc",
    "name" => "videos.name"
  }
  DEFAULT_ORDER = "videos.name"

  # Concerns
  include PgSearch
  multisearchable against: [:name]

  include Searchable
  def self.searchable_attributes
    %w(name)
  end

  # Validations
  validates :name, :embed_url, presence: true
end
