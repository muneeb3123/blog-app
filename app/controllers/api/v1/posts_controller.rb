class Api::V1::PostsController < ApplicationController

  # GET /posts
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    render json: @posts
  end
end
