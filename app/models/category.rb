class Category < ActiveRecord::Base
  has_many :postcategories
  has_many :posts, through: :postcategories

  validates :name, presence: true, uniqueness: true
end
