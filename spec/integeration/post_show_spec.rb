require 'rails_helper'

RSpec.describe 'post show', type: :system do
  let!(:user) do
    User.create(
      name: 'Muneeb Rehman',
      photo: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      bio: 'Student - Developer',
      posts_counter: 0
    )
  end

  let!(:post) do
    Post.create(
      author: user,
      title: 'post#1',
      text: 'this is my first post!',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  before do
    15.times do |i|
      Comment.create(
        author: user,
        post: post,
        text: "hy larry! #{i + 1}"
      )
    end
  end

  it 'should display posts information' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.author.name)
    expect(page).to have_content('Comments: 15, Likes: 0')
    expect(page).to have_content(post.text)

    post.comments.each do |c|
      expect(page).to have_content(c.author.name)
      expect(page).to have_content(c.text)
    end
  end
end
