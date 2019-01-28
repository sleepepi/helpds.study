# frozen_string_literal: true

# Helps generate URLs for user profile pictures.
module ProfilesHelper
  def profile_picture_tag(user, size: 128, style: nil)
    image_tag(
      picture_profile_path(user.username, thumb: size <= 64 ? "1" : nil),
      alt: "",
      class: "rounded img-ignore-selection",
      style: "max-height: #{size}px; max-width: #{size}px;"
    )
  end
end
