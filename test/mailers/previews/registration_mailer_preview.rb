# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/registration_mailer
class RegistrationMailerPreview < ActionMailer::Preview
  def welcome
    user = User.new(full_name: "New User", username: "newuser", email: "newuser@example.com")
    RegistrationMailer.welcome(user)
  end

  def account_registered
    admin = User.new(full_name: "Admin User", username: "adminuser", email: "admin@example.com")
    user = User.new(full_name: "New User", username: "newuser", email: "newuser@example.com")
    RegistrationMailer.account_registered(admin, user)
  end

  def account_confirmed
    admin = User.new(full_name: "Admin User", username: "adminuser", email: "admin@example.com")
    user = User.new(full_name: "New User", username: "newuser", email: "newuser@example.com")
    RegistrationMailer.account_confirmed(admin, user)
  end

  def account_approved
    user = User.new(full_name: "New User", username: "newuser", email: "newuser@example.com")
    RegistrationMailer.account_approved(user)
  end
end
