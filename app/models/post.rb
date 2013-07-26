class Post < ActiveRecord::Base
  include Voteable
  include Sluggable
  belongs_to :user
  has_many :comments, :order => 'created_at DESC'
  has_many :postcategories
  has_many :categories, through: :postcategories
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :url, presence: true
  validates :categories, presence: true

  after_validation :sluggify_this

  def sluggify_this
    generate_slug(Post, self.title)
  end

end
