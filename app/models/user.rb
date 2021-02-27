# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  auth_token         :string
#  email              :string           not null
#  encrypted_password :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  has_secure_token :auth_token

  has_many :votes, dependent: :destroy
end
