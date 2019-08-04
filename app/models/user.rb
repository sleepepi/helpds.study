# frozen_string_literal: true

# Defines the user model, relationships, and permissions.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Callbacks
  after_commit :new_registration!, on: :create

  # Uploaders
  mount_uploader :profile_picture, ResizableImageUploader

  # Constants
  ORDERS = {
    "activity desc" => "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END) desc",
    "activity" => "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END)",
    "logins desc" => "users.sign_in_count desc",
    "logins" => "users.sign_in_count"
  }
  DEFAULT_ORDER = "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END) desc"

  # Concerns
  include Deletable
  include Squishable
  squish :full_name, :keywords, :phone, :role

  include Strippable
  strip :username

  include Searchable
  def self.searchable_attributes
    %w(full_name email username)
  end

  include PgSearch::Model
  multisearchable against: [:full_name, :email, :username, :keywords, :phone, :role]

  # Scopes
  scope :admins, -> { current.where(admin: true) }
  scope :editors, -> { current.where(editor: true).or(admins) }

  # Validations
  validates :full_name, presence: true
  validates :full_name, format: { with: /\A.+\s.+\Z/, message: "must include first and last name" }
  validates :username, presence: true
  validates :username, format: {
                         with: /\A[a-zA-Z0-9]+\Z/i,
                         message: "may only contain letters or digits"
                       },
                       exclusion: { in: %w(new edit show create update destroy) },
                       allow_blank: true,
                       uniqueness: { case_sensitive: false }

  # Relationships
  belongs_to :site, optional: true

  # Methods
  def incomplete_profile?
    role.blank? || phone.blank? || self[:profile_picture].blank?
  end

  def email=(email)
    super(email.try(:downcase))
  end

  # Overwrite default editor? method.
  def editor?
    self[:editor] || admin?
  end

  def check_approval_email
    return unless approved? && approval_sent_at.nil?

    update(approval_sent_at: Time.zone.now)
    send_approval_email!
  end

  def disposable_email?
    false
  end

  # Overriding Devise built-in active_for_authentication? method.
  def active_for_authentication?
    super && !deleted? && approved?
  end

  # Override Devise built-in password reset notification email method
  def send_reset_password_instructions
    return unless EMAILS_ENABLED && !deleted?

    super
  end

  # Override Devise built-in unlock instructions notification email method
  def send_unlock_instructions
    return unless EMAILS_ENABLED && !deleted?

    super
  end

  def send_confirmation_instructions
    return unless EMAILS_ENABLED && !deleted? && !disposable_email?

    super
  end

  def send_on_create_confirmation_instructions
    return unless EMAILS_ENABLED && !deleted? && !disposable_email?

    send_welcome_email!
  end

  def send_welcome_email!
    RegistrationMailer.welcome(self).deliver_later if EMAILS_ENABLED
  end

  def new_registration!
    return unless EMAILS_ENABLED

    User.admins.find_each do |admin|
      RegistrationMailer.account_registered(admin, self).deliver_later
    end
  end

  # Override Devise::Confirmable#after_confirmation
  def after_confirmation
    return unless EMAILS_ENABLED

    User.admins.find_each do |admin|
      RegistrationMailer.account_confirmed(admin, self).deliver_later
    end
  end

  def send_approval_email!
    RegistrationMailer.account_approved(self).deliver_later if EMAILS_ENABLED
  end
end
