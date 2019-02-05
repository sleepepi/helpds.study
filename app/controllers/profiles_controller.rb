# frozen_string_literal: true

# Displays user profile pictures.
class ProfilesController < ApplicationController
  before_action :find_user, only: [:picture]

  def picture
    profile_picture = if params[:thumb] == "1"
      @user&.profile_picture&.thumb
    else
      @user&.profile_picture
    end

    if Rails.env.production?
      if profile_picture&.url.present?
        redirect_to profile_picture.url(query: { "response-content-disposition" => "inline" }), allow_other_host: true
      else
        head :ok
      end
    else
      send_file_if_present profile_picture, disposition: "inline"
    end
  end

  private

  def find_user
    @user = User.current.find_by("LOWER(username) = ?", params[:id].to_s.downcase)
  end
end
