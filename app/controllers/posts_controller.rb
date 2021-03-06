class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:edit, :new, :create, :update, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
    newest = Post.all.select { |post| Time.now - post.created_at < 7200 }
    other_posts = Post.all.reject { |post| Time.now - post.created_at < 7200 }
    @posts = newest + other_posts.sort_by { |post| vote_total(post) }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end


  def create
    @user = current_user
    @post = Post.new(post_params)
    if @post.save
      @user.posts << @post
      redirect_to root_path, notice: "Post was successfully created"
    else
      render :new
    end
  end

  def edit

  end

  def update
    @post.update_attributes(post_params)

    if @post.update(post_params)
      redirect_to post_path, notice: "Post successfully updated"
    else
      render :edit
    end
  end

  def vote
    respond_to do |format|

      format.js do
        if current_user.already_voted(@post)
          render js: "alert('You can only vote on a post once!')"
        else
          Vote.create(voteable: @post, user: current_user, vote: params[:vote])
          format.js
        end
      end
    end
  end



private

  def set_post
    @post = Post.find_by slug: (params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :url, { :category_ids => [] })
  end

  def require_creator
    access_denied unless logged_in? && current_user == @post.user
  end

  def vote_total(obj)
    obj.votes.where(vote: true).size - obj.votes.where(vote: false).size
  end
end
