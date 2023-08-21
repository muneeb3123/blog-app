class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new]
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
    @comment = Comment.find(params[:id])
    @user = @comment.author
    @post = @comment.post
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_post_path(@user, @post), notice: 'Comment was successfully deleted.'
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end
end
