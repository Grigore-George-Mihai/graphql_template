# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email: ENV.fetch("DEFAULT_USER_EMAIL", "user@example.com")) do |user|
  user.first_name = "Normal"
  user.last_name = "User"
  user.password = ENV.fetch("DEFAULT_USER_PASSWORD", "UserPassword123!")
  user.password_confirmation = ENV.fetch("DEFAULT_USER_PASSWORD", "UserPassword123!")
  user.role = :user
end

User.find_or_create_by!(email: ENV.fetch("DEFAULT_ADMIN_EMAIL", "admin@example.com")) do |user|
  user.first_name = "Admin"
  user.last_name = "User"
  user.password = ENV.fetch("DEFAULT_ADMIN_PASSWORD", "AdminPassword123!")
  user.password_confirmation = ENV.fetch("DEFAULT_ADMIN_PASSWORD", "AdminPassword123!")
  user.role = :admin
end
