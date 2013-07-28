class User < ActiveRecord::Base
  include SluggifyThisJs
  has_many :posts
  has_many :comments
  has_many :votes

  validates :password, presence: true, length: {minimum: 4}
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}

  has_secure_password validations: false

  after_validation :sluggify_this

  def already_voted(obj)
    self.votes.where(voteable: obj).size > 0
  end

  def admin?
    self.role == "admin"
  end

  def sluggify_this
    generate_slug(User, self.username)
  end

end
