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
class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :issue
end
