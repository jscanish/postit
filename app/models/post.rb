class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :order => 'created_at DESC'
  has_many :postcategories
  has_many :categories, through: :postcategories
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validates :categories, presence: true

  def vote_total
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end

end
