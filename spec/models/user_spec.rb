require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts counter should be numaric' do
    subject.name = 'muneeb'
    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'posts counter should be greater or equal to 0' do
    subject.name = 'muneeb'
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should display three most recent posts' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                likes_counter: 0)
    post2 = Post.create(author: user, title: 'Hello', text: 'This is my second post', comments_counter: 0,
                        likes_counter: 0)
    post3 = Post.create(author: user, title: 'Hello', text: 'This is my third post', comments_counter: 0,
                        likes_counter: 0)
    post4 = Post.create(author: user, title: 'Hello', text: 'This is my fourth post', comments_counter: 0,
                        likes_counter: 0)
    expect(user.three_most_recent_posts).to contain_exactly(post4, post3, post2)
  end
end
