class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  after_create :update_post_comments_counte
  after_destroy :update_post_comments_counte

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
