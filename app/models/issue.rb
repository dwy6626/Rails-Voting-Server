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

  def agree_count
    votes.where(agree: true).count
  end

  def disagree_count
    votes.where(agree: false).count
  end
end
