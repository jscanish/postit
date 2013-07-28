class Category < ActiveRecord::Base
  include SluggifyThisJs
  has_many :postcategories
  has_many :posts, through: :postcategories

  validates :name, presence: true, uniqueness: true

  after_validation :sluggify_this

  def sluggify_this
    generate_slug(Category, self.name)
  end
end
