require 'rails_helper'

RSpec.describe 'post index', type: :system do
  let!(:user) do
    User.create(
      name: 'Muneeb Rehman',
      photo: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      bio: 'Student - Developer',
      posts_counter: 0
    )
  end

  before do
    15.times do |i|
      Post.create(
        author: user,
        title: "post##{i + 1}",
        text: "this is my #{i + 1} post!",
        comments_counter: 0,
        likes_counter: 0
      )
    end
  end

  let!(:comment) do
    Comment.create(
      author: user,
      post: Post.first,
      text: 'hy larry!'
    )
  end

  it 'displays the user information' do
    visit user_posts_path(user)
    expect(page).to have_content('Muneeb Rehman')
    expect(page).to have_css("img[src='#{user.photo}']")
    expect(page).to have_content('Number of posts: 15')
  end
  it 'Check the first page of posts also see how many comments and likes' do
    visit user_posts_path(user)
    expect(page).to have_content('post#2')
    expect(page).to have_content('this is my 2 post!')
    expect(page).to have_content('Comments: 0, Likes: 0')
    expect(page).to have_content('post#3')
    expect(page).to have_content('this is my 3 post!')
    expect(page).to have_content('Comments: 0, Likes: 0')
  end

  it 'Check for pagination and first comment on post 1' do
    visit user_posts_path(user)
    click_link '4'
    expect(page).to have_content('post#14')
    expect(page).to have_content('this is my 14 post!')
    expect(page).to have_content('post#15')
    expect(page).to have_content('this is my 15 post!')
    expect(page).to have_content(comment.text)
  end

  it 'When click on a post, it redirected to that post show page.' do
    visit user_posts_path(user)
    post = Post.second
    click_link post.title
    expect(page).to have_current_path(user_post_path(user, post))
  end
end
