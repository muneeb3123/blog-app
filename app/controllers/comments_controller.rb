class CommentsController < ApplicationController
    def new
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new
    end
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comments_params)
        @comment.author = current_user
        if @comment.save
            redirect_to user_post_path(current_user, @post), notice: 'Comment was successfully created.'
          else
            render 'posts/show'
          end
    end

    private

    def comments_params
        params.require(:comment).permit(:text)
    end
end
