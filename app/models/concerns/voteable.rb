# Must have votes association with boolean 'vote' column
module Voteable

  def vote_total
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end

end
