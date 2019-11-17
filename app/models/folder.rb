# frozen_string_literal: true

# Tracks files uploaded to the folder.
class Folder < ApplicationRecord
  # Uploaders
  mount_uploader :zipped_folder, ZipUploader

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

  def generate_zipped_folder!
    zip_name = "helpds-study-#{category.slug}-#{slug}.zip"
    temp_zip_file = Tempfile.new(zip_name)
    begin
      stream = Zip::OutputStream::write_buffer do |zos|
        documents.each do |document|
          zos.put_next_entry document.filename
          zos.write document.file.read
        end
      end
      stream.rewind
      temp_zip_file.write(stream.sysread)
      temp_zip_file.define_singleton_method(:original_filename) do
        zip_name
      end
      update zipped_folder: temp_zip_file
      update zipped_folder_byte_size: zipped_folder.size
    ensure
      # Close and delete the temp file
      temp_zip_file.close
      temp_zip_file.unlink
    end
  end
end
