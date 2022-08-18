class PostsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  def index
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = @user.posts.includes(comments: [:user]).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(current_user)
      # flash[:success] = 'Post created successfully'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
