require 'rails_helper'

RSpec.describe 'User show', type: :system do
  let!(:user) do
    User.create(
      name: 'Muneeb Rehman',
      photo: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      bio: 'Student - Developer',
      posts_counter: 0
    )
  end

  let!(:post1) do
    Post.create(
      author: user,
      title: 'post#1',
      text: 'This is my first post!',
      comments_counter: 0,
      likes_counter: 0
    )
  end


  it 'show user informations' do
    visit user_path(user)
    expect(page).to have_css("img[src='#{user.photo}']")
    expect(page).to have_content(user.name)
    expect(page).to have_content('Number of posts: 2')
    expect(page).to have_content(user.bio)
  end

  it 'displays posts information' do
    visit user_path(user)
   
    expect(page).to have_content(post1.title)
    expect(page).to have_content(post1.text)

    expect(page).to have_content('see all posts')
    click_link 'see all posts'
    expect(page).to have_current_path(user_posts_path(user))

    visit user_path(user)
    click_link "#{post1.title}"
    expect(page).to have_current_path(user_post_path(user, post1))
    
  end
end
