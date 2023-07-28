require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(Title: 'This is a post', CommentsCounter: 2, LikesCounter: 1) }

  before { subject.save }

  it 'Title should be present' do
    subject.Title = nil
    expect(subject).to_not be_valid
  end

  it 'Title must not exceed 250 characters' do
    subject.Title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'CommentsCounter should be greater than or equal to 0' do
    subject.CommentsCounter = -1
    expect(subject).to_not be_valid
  end

  it 'LikesCounter should be greater than or equal to 0' do
    subject.LikesCounter = -1
    expect(subject).to_not be_valid
  end

  describe '#increment_post_counter' do
    it 'increments the post_counter of the associated user' do
      user = User.create(name: 'John Doe', post_counter: 0)
      post = Post.create(author_id: user.id, Title: 'Second Post', Text: 'More thoughts', CommentsCounter: 0,
                         LikesCounter: 0)

      expect { post.increment_post_counter }.to change { user.reload.post_counter }.by(1)
    end
  end

  describe '#decrement_post_counter' do
    it 'decrements the post_counter of the associated user' do
      user = User.create(name: 'John Doe', post_counter: 4)
      post = Post.create(author_id: user.id, Title: 'Second Post', Text: 'More thoughts', CommentsCounter: 0,
                         LikesCounter: 0)

      expect { post.decrement_post_counter }.to change { user.reload.post_counter }.by(-1)
    end
  end

  describe '#recent_comments' do
    it 'returns the five most recent comments' do
      # Create a user
      user = User.create(name: 'John Doe', post_counter: 0)

      # Create a post
      post = Post.create(author_id: user.id, Title: 'Second Post', Text: 'More thoughts', CommentsCounter: 0,
                         LikesCounter: 0)

      # Create test comments for the post
      Comment.create(post_id: post.id, author_id: user.id, Text: 'Hi Tom!')
      comment2 = Comment.create(post_id: post.id, author_id: user.id, Text: 'Hi Tom!')
      comment3 = Comment.create(post_id: post.id, author_id: user.id, Text: 'Hi Tom!')
      comment4 = Comment.create(post_id: post.id, author_id: user.id, Text: 'Hi Tom!')
      comment5 = Comment.create(post_id: post.id, author_id: user.id, Text: 'Hi Tom!')
      comment6 = Comment.create(post_id: post.id, author_id: user.id, Text: 'Hi Tom!')

      newer_comments = [comment6, comment5, comment4, comment3, comment2]

      # Ensure that only the five most recent comments are returned
      expect(post.recent_comments).to eq(newer_comments)
    end
  end
end
