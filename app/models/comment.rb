class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_post_comments_counte

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
