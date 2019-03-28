# frozen_string_literal: true

# Generic mailer class defines layout and email sender.
class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV["website_name"]} <#{ActionMailer::Base.smtp_settings[:email]}>"
  add_template_helper(EmailHelper)
  layout "mailer"

  protected

  def setup_email
  #   location = "app/assets/images/logos/help-ds-without-longform.png"
  #   attachments.inline["help-ds-logo.png"] = File.read(location)
  # rescue
  #   nil
  end
end
