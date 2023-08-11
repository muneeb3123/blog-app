class LikesController < ApplicationController
  def create
    @target_post = Post.find(params[:post_id])
    existing_like = @target_post.likes.find_by(author: current_user)

    if existing_like
      flash[:alert] = 'You have already expressed your appreciation for this post.'
    else
      @new_like = current_user.likes.new(post: @target_post)
      if @new_like.save
        flash[:notice] = 'Youhave successfully shown your support for this post.'
      else
        flash[:alert] = 'Oops, something went wrong. Please try again.'
      end
    end
    redirect_to user_post_path(@target_post.author, @target_post)
  end
end
