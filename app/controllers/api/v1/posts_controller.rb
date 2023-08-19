class Api::V1::PostsController < ApplicationController
  load_and_authorize_resource

      # GET /posts
      def index
        @user = User.find(params[:user_id])
        @posts = @user.posts

        render json: @posts
      end
end
