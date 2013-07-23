class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  validates :password, presence: true, length: {minimum: 4}
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}

  has_secure_password validations: false

  def already_voted(obj)
    self.votes.where(voteable: obj).size > 0
  end
end
