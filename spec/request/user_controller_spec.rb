require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET #index' do
    it 'returns a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to match('This page shows all users')
    end
  end

  describe 'Get #show' do
    it 'returns a successful response' do
      get '/users/:id'
      expect(response).to be_successful
    end

    it 'renders the correct template' do
      get '/users/:id'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users/:id'
      expect(response.body).to match('This page shows single user by specific id')
    end
  end
end
