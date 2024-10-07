# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :jti, null: false

      t.timestamps
    end

    add_index :users, "LOWER(email)", unique: true
    add_index :users, :jti, unique: true
  end
end
