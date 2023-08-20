require 'swagger_helper'

RSpec.describe 'API Comments ', type: :request do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string, description: 'ID for user'
    parameter name: 'post_id', in: :path, type: :string, description: 'ID for post'

    get('list comments for post') do
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, description: 'ID for user'
      parameter name: :post_id, in: :path, type: :string, description: 'ID for post'

      response(200, 'successful') do
        examples 'application/json' => [
          { id: 1, author_id: 1, post_id: 1, text: 'Comment 1', created_at: '2021-01-01 00:00:00',
            updated_at: '2021-01-01 00:00:00' },
          { id: 2, author_id: 1, post_id: 1, text: 'Comment 2', created_at: '2021-01-01 00:00:00',
            updated_at: '2021-01-01 00:00:00' }
        ]
        run_test!
      end

      response(404, 'not found') do
        let(:user_id) { 'invalid' }
        let(:post_id) { 'invalid' }
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

    post('Create comment') do
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, description: 'ID for user'
      parameter name: :post_id, in: :path, type: :string, description: 'ID for post'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          content: { type: :string }
        },
        required: ['content']
      }

      response(201, 'comment created') do
        let(:comment) { { content: 'New Comment' } }
        run_test!
      end

      response(422, 'invalid request') do
        let(:comment) { { content: '' } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:comment) { { content: 'New Comment' } }
        run_test!
      end

      response(403, 'forbidden') do
        let(:comment) { { content: 'New Comment' } }
        run_test!
      end

      response(500, 'internal server error') do
        let(:comment) { { content: 'New Comment' } }
        run_test!
      end
    end
  end
end
