# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  agree      :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  issue_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_votes_on_issue_id              (issue_id)
#  index_votes_on_user_id               (user_id)
#  index_votes_on_user_id_and_issue_id  (user_id,issue_id) UNIQUE
#
FactoryBot.define do
  factory :vote do
    user
    issue
    trait :disagree do
      agree { false }
    end
  end
end
