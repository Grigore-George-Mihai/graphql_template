# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  let(:valid_user) { create(:user) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value("user@example.com").for(:email) }

    it {
      expect(valid_user).not_to allow_value("invalid_email").for(:email).with_message(I18n.t("errors.messages.invalid_email"))
    }

    context "when validating uniqueness of email" do
      let(:user_with_email) { create(:user, email: "test@example.com") }

      it "validates uniqueness of email case-insensitively" do
        expect(user_with_email).to validate_uniqueness_of(:email).case_insensitive
      end
    end

    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    context "when the password lacks a special character" do
      it "is invalid" do
        user_without_special_char = build(:user, password: "Password1", password_confirmation: "Password1")
        expect(user_without_special_char).not_to be_valid
        expect(user_without_special_char.errors[:password]).to include(I18n.t("errors.messages.password_complexity"))
      end
    end

    context "when the password meets all requirements" do
      it "is valid" do
        expect(valid_user).to be_valid
      end
    end
  end

  describe "Enums" do
    it "defines roles with correct values" do
      expect(described_class.roles).to eq("user" => 0, "admin" => 1)
    end
  end

  describe "jti handling" do
    context "when a user is created" do
      it "generates a unique jti" do
        expect(valid_user.jti).to be_present
        expect(valid_user.jti).to be_a(String)
      end
    end

    context "when a user's jti is regenerated" do
      it "changes the jti value" do
        old_jti = valid_user.jti
        valid_user.regenerate_jti!
        expect(valid_user.jti).not_to eq(old_jti)
      end
    end
  end
end
