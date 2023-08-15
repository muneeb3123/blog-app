require 'rails_helper'

RSpec.describe 'User Index', type: :system do
  let!(:user1) do
    User.create(
      name: 'Muneeb Rehman',
      photo: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      bio: 'Student - Developer',
      posts_counter: 0
    )
  end

  let!(:user2) do
    User.create(name: 'Larry',
                photo: 'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                bio: 'Student - Developer',
                posts_counter: 0)
  end

  it 'displays the username and profile picture of all other users and display posts counter' do
    visit users_path
    expect(page).to have_content('Muneeb Rehman')
    expect(page).to have_css("img[src='#{user1.photo}']")
    expect(page).to have_content('Number of posts: 0')

    expect(page).to have_content('Larry')
    expect(page).to have_css("img[src='#{user2.photo}']")
    expect(page).to have_content('Number of posts: 0')
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path

    click_link 'Muneeb Rehman'
    expect(page).to have_current_path(user_path(user1))
    visit users_path

    click_link 'Larry'
    expect(page).to have_current_path(user_path(user2))
  end
end
