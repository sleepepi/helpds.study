# frozen_string_literal: true

# Public pages.
class ExternalController < ApplicationController
  # GET /
  def landing
    render layout: "layouts/full_page"
  end

  # # GET /contact
  # def contact
  # end

  # # GET /privacy-policy
  # def privacy_policy
  # end

  # GET /version
  # GET /version.json
  def version
    render layout: "layouts/full_page"
  end
end
