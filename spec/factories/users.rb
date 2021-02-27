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
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.test" }
    password { 'mypass' }
  end
end
