require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'should update likes counter' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    user2 = User.create(name: 'muneeb', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)
    Like.create(author: user2, post: post)
    Like.create(author: user2, post: post)
    expect(post.reload.likes_counter).to eq(2)
  end
end
