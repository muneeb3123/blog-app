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
    
      let!(:post1) do
        Post.create(
          author: user,
          title: 'post#1',
          text: 'This is my first post!',
          comments_counter: 0,
          likes_counter: 0
        )
      end
      let!(:post2) do
        Post.create(
          author: user,
          title: 'post#2',
          text: 'This is my second post!',
          comments_counter: 0,
          likes_counter: 0
        )
      end
      let!(:comment) do
        Comment.create(
          author: user,
          post: post2,
          text: 'hy larry!',
        )
      end

      it 'displays the usernam' do
        visit user_posts_path(user)
        sleep(10)
        expect(page).to have_content('Muneeb Rehman')
        expect(page).to have_css("img[src='#{user.photo}']")
        expect(page).to have_content('Number of posts: 2')
        expect(page).to have_content(post1.title)
        expect(page).to have_content(post1.text)
        expect(page).to have_content(post2.title)
        expect(page).to have_content(post2.text)
        expect(page).to have_content(comment.text)
      end
end