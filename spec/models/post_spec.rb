require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { described_class.new }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should show five most recent comments' do
    user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                       posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                       likes_counter: 0)
    Comment.create(author: user, post: post, text: 'Hi Tom!')
    comment2 = Comment.create(author: user, post: post, text: 'Hi Tom!')
    comment3 = Comment.create(author: user, post: post, text: 'Hi Tom!')
    comment4 = Comment.create(author: user, post: post, text: 'Hi Tom!')
    comment5 = Comment.create(author: user, post: post, text: 'Hi Tom!')
    comment6 = Comment.create(author: user, post: post, text: 'Hi Tom!')
    expect(post.five_most_recent_comments).to contain_exactly(comment6, comment5, comment4, comment3, comment2)
  end
end
