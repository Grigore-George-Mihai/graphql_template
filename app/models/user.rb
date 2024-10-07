# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email
  before_create :set_jti

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t("errors.messages.invalid_email") }
  validates :password, presence: true, length: { minimum: 6 },
                       format: { with: /\A(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]+\z/, message: I18n.t("errors.messages.password_complexity") }
  validates :first_name, :last_name, presence: true

  def set_jti
    self.jti ||= SecureRandom.uuid
  end

  def regenerate_jti!
    update_column(:jti, SecureRandom.uuid)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
