# frozen_string_literal: true

# Allows models to be flagged as deleted.
module Deletable
  extend ActiveSupport::Concern

  included do
    scope :current, -> { where deleted: false }
  end

  def destroy
    update(deleted: true, deleted_at: Time.zone.now)
  end

  def revive
    update(deleted: false, deleted_at: nil)
  end
end
