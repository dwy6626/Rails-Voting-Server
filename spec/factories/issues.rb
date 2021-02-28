# == Schema Information
#
# Table name: issues
#
#  id          :integer          not null, primary key
#  description :text
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :issue do
    title { 'Wuhan coronavirus is created by China' }
    description { 'some descriptions' }
  end
end
