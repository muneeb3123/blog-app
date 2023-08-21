class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :new]
  # load_and_authorize_resource
  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 4)
  end

  def show
    @user = User.includes(posts: :comments).find(params[:user_id])
    @post = @user.posts.includes(comments: :author).find(params[:id])
  end

  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'post created successfully.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.author
    authorize! :destroy, @post
    @post.destroy
    redirect_to user_posts_path(@user), notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
