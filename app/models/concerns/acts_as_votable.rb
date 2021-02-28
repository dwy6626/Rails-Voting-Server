module ActsAsVotable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy
  end

  def vote!(issue, agree)
    voted = votes.where(issue: issue).take
    if voted
      voted.update! agree: agree
    else
      votes.create! issue: issue, agree: agree
    end
  end
end
