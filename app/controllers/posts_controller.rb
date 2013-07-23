class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:edit, :new, :create, :update, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
    a = []
    Post.all.each do |post|
      a << post
    end
    @posts = a.sort_by { |post| vote_total(post) }.reverse
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
    if current_user.already_voted(@post)
      flash[:error] = "You can only vote on a post once!"
      redirect_to :back
    else
      Vote.create(voteable: @post, user: current_user, vote: params[:vote])
      redirect_to :back, notice: "Vote Counted"
    end
  end


private

  def set_post
    @post = Post.find(params[:id])
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
