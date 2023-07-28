class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments

  after_save :update_user_posts_counter

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
