# frozen_string_literal: true

ENV["slice_url"] ||= \
  case ENV["WEBSITE_SETTINGS"]
  when "production"
    "https://sliceable.org"
  when "staging"
    "https://staging.sliceable.org"
  else # localhost
    "http://localhost/edge/sliceable.org"
  end
