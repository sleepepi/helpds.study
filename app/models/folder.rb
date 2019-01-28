# frozen_string_literal: true

# Tracks files uploaded to the folder.
class Folder < ApplicationRecord
  # Constants
  DOCS_PER_PAGE = 20

  # Concerns
  include Sluggable
  include Squishable
  squish :name

  # Validations
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false, scope: [:category_id] }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: { case_sensitive: false, scope: [:category_id] },
                   allow_nil: true

  # Relationships
  belongs_to :category, counter_cache: true
  has_many :documents, dependent: :destroy

  # Methods

  def attach_file!(file)
    documents.create(
      file: file,
      byte_size: file.size,
      filename: file.original_filename,
      content_type: Document.content_type(file.original_filename)
    )
  end
end
