# frozen_string_literal: true

# Sends welcome and account approval emails to new users, and sends user
# registered emails to admins.
class RegistrationMailer < ApplicationMailer
  def welcome(user)
    setup_email
    @user = user
    @email_to = user.email
    mail(to: @email_to, subject: "Welcome to #{ENV["website_name"]}!")
  end

  def account_approved(user)
    setup_email
    @user = user
    @email_to = user.email
    mail(to: @email_to, subject: "Your #{ENV["website_name"]} account has been approved")
  end

  def user_registered(admin, user)
    setup_email
    @admin = admin
    @user = user
    @email_to = admin.email
    mail(to: admin.email,
         subject: "#{user.full_name} registered for #{ENV["website_name"]}",
         reply_to: user.email)
  end
end
