class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  # load_and_authorize_resource

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comments_params)
    @comment.author = current_user
    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_post_path(@user,@post), notice: 'Comment was successfully deleted.'
  end  

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
