class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all(order: "created_at DESC")
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to root_path, notice: "Post was successfully created"
    else
      render :new
    end
  end

  def edit

  end

  def update
    @post.update_attributes(post_params)

    if @post.save
      redirect_to post_path, notice: "Post successfully updated"
    else
      render :edit
    end
  end


private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit!
  end

end
