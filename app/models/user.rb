class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  validates :password, presence: true, length: {minimum: 4}
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}

  after_validation :generate_slug

  has_secure_password validations: false

  def already_voted(obj)
    self.votes.where(voteable: obj).size > 0
  end

  def admin?
    self.role == "admin"
  end

  def to_param
    self.slug
  end

  def generate_slug
    str = to_slug(self.username)
    count = 2
    obj = Post.where(slug: str).first
    while obj && obj != self
      str = str + "-" + count.to_s
      obj = Post.where(slug: str).first
      count += 1
    end
    self.slug = str.downcase
  end

  def to_slug(name)
    #strip the string
    ret = name.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric with dash
     ret.gsub! /\s*[^A-Za-z0-9]\s*/, '-'

     #convert double dashes to single
     ret.gsub! /-+/,"-"

     #strip off leading/trailing dash
     ret.gsub! /\A[-\.]+|[-\.]+\z/,""

     ret
  end
end
