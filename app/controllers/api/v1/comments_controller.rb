module Api
  module V1
    class CommentsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create]

      before_action :authenticate_user!
      before_action :set_comment, only: %i[show update destroy]

      # GET /comments
      def index
        post = Post.find(params[:post_id])
        @comments = post.comments
        # @comments = Comment.all

        render json: @comments
      end

      # POST /comments
      def create
        post = Post.find(params[:post_id])
        @comment = post.comments.new(comment_params)
        # @comment = Comment.new(comment_params)
        @comment.user = current_user

        if @comment.save
          render json: @comment, status: :created, location: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:content)
      end
    end
  end
end
