# require 'rails_helper'

# RSpec.describe PostsController, type: :request do
#   describe 'GET #index' do
#     it 'should return a succsessfull response' do
#       get '/users/:user_id/posts'
#       expect(response).to be_successful
#     end
#     it 'should render a template' do
#       get '/users/:user_id/posts'
#       expect(response).to render_template(:index)
#     end
#     it 'includes the correct placeholder text in the response body' do
#       get '/users/:user_id/posts'
#       expect(response.body).to match('This page shows all posts')
#     end
#   end
#   describe 'GET #index' do
#     it 'should return a succsessfull response' do
#       get '/users/:user_id/posts/:id'
#       expect(response).to be_successful
#     end
#     it 'should render a template' do
#       get '/users/:user_id/posts/:id'
#       expect(response).to render_template(:show)
#     end
#     it 'includes the correct placeholder text in the response body' do
#       get '/users/:user_id/posts/:id'
#       expect(response.body).to match('This page shows all posts by single user')
#     end
#   end
# end
