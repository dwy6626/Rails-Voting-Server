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
class Issue < ApplicationRecord
  has_many :votes, dependent: :destroy
end
