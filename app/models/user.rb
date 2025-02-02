# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  normalizes :email, with: ->(email) { email.downcase.strip }
  before_create -> { self.jti ||= SecureRandom.uuid }

  enum :role, { user: 0, admin: 1 }, validate: true

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t("errors.messages.invalid_email") }
  validates :password, presence: true, length: { minimum: 6 },
                       format: { with: /\A(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]+\z/, message: I18n.t("errors.messages.password_complexity") }
  validates :first_name, :last_name, presence: true

  def regenerate_jti!
    update_column(:jti, SecureRandom.uuid)
  end
end
