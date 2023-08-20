require 'swagger_helper'

RSpec.describe 'Posts API api/v1/posts', type: :request do
  path '/api/v1/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

    get('list posts') do
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, description: 'Id of user'

      response(200, 'successful') do
        examples 'application/json' => [
          { id: 1, author_id: 1, title: 'Post 1', text: 'Text 1', comments_counter: 2, likes_counter: 3,
            created_at: '2021-01-01 00:00:00', updated_at: '2021-01-01 00:00:00' },
          { id: 2, author_id: 1, title: 'Post 2', text: 'Text 2', comments_counter: 1, likes_counter: 0,
            created_at: '2021-01-01 00:00:00', updated_at: '2021-01-01 00:00:00' }
        ]
        run_test!
      end

      response(404, 'Failed to fetch') do
        let(:user_id) { 'invalid' }
        run_test!
      end

      response(401, 'unauthorized') do
        run_test!
      end

      response(403, 'forbidden') do
        run_test!
      end

      response(500, 'internal server error') do
        run_test!
      end
    end
  end
end
