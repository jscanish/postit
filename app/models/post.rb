class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :postcategories
  has_many :categories, through: :postcategories

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true

end
