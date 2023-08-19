class Api::V1::CommentsController < ApplicationController
  load_and_authorize_resource

  # GET /comments
  def index
    @user = Post.find(params[:id])
    post = @user.posts.find(params[:post_id])
    @comments = post.comments

    render json: @comments
  end

  # POST /comments
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)

    # authorize! :create, @comment

    @comment.user = current_user

    if @comment.save
      render json: { success: 'Comment added!' }
    else
      render json: { error: new_comment.errors.full_messages.join(', ') }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
