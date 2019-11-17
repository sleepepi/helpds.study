# frozen_string_literal: true

# Represents a file uploaded to a folder. A document can be featured to be
# displayed on the dashboard, and tracks the number of times the file has been
# downloaded.
class Document < ApplicationRecord
  # Uploaders
  mount_uploader :file, GenericUploader

  # Constants
  ORDERS = {
    "size" => "documents.byte_size",
    "size desc" => "documents.byte_size desc",
    "oldest" => "documents.created_at",
    "latest" => "documents.created_at desc",
    "name" => "LOWER(documents.filename)",
    "name desc" => "LOWER(documents.filename) desc"
  }
  DEFAULT_ORDER = "LOWER(documents.filename)"

  include Squishable
  squish :keywords

  # Concerns
  include PgSearch::Model
  multisearchable against: [:filename, :content_type, :keywords]

  # Validations
  validates :filename, presence: true,
                       uniqueness: { case_sensitive: false, scope: [:folder_id] }

  # Scopes
  scope :latest_files, -> do
    joins(:folder).merge(Folder.where(archived: false).joins(:category).merge(Category.sidebar)).reorder(created_at: :desc).limit(10)
  end

  scope :top_files, -> do
    joins(:folder).merge(Folder.where(archived: false).joins(:category).merge(Category.sidebar)).reorder(download_count: :desc)
  end

  scope :featured_files, -> do
    joins(:folder).merge(Folder.where(archived: false).joins(:category).merge(Category.sidebar)).where(featured: true).reorder(created_at: :desc)
  end

  # Relationships
  belongs_to :folder, counter_cache: true

  # Methods

  def self.content_type(filename)
    MIME::Types.type_for(filename).first.content_type
  end

  def page
    index = folder.documents.order(Arel.sql("LOWER(documents.filename)")).pluck(:id).index(id)
    page = index / Folder::DOCS_PER_PAGE + 1 if index
    page = nil if page == 1
    page
  end
end
