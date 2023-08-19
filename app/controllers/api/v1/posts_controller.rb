module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_post, only: %i[show update destroy]

      # GET /posts
      def index
        user = User.find(params[:user_id])
        posts = user.posts

        render json: posts
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:title, :text, :author_id)
      end
    end
  end
end
