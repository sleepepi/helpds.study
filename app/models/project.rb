# frozen_string_literal: true

# Allows reports to connect to Slice projects.
class Project < ApplicationRecord
  # Concerns
  include Squishable
  squish :name, :access_token

  # Validations
  validates :name, :access_token, presence: true

  # Relationships
  has_many :reports

  # Methods
  def slice_url
    "#{ENV["slice_url"]}/api/v1/projects/#{access_token}"
  end
end
