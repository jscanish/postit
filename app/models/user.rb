class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates :password, presence: true, length: {minimum: 4}
  validates :username, presence: true, uniqueness: true, length: {minimum: 4}

  has_secure_password validations: false
end
