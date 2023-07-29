require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'should update comments counter' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    user2 = User.create(name: 'muneeb', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)
    Comment.create(author: user2, post: post, text: 'hy first')
    Comment.create(author: user2, post: post, text: 'hy second')
    expect(post.reload.comments_counter).to eq(2)
  end
end
