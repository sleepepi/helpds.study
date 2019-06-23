# frozen_string_literal: true

namespace :reports do
  desc "Refresh reports from a cron job on a scheduled basis."
  task refresh: :environment do
    Report
      .where(archived: false)
      .where("last_cached_at < ? OR last_cached_at IS NULL", Time.zone.now - 1.day) # 30.minutes
      .find_each(&:refresh!)
  end
end
