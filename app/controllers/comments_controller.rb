class CommentsController < ApplicationController
  before_action :require_user, only: [:create]

   def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit!)
    @comment.post = @post

    if @comment.save
      redirect_to post_path(@post), notice: "Comment successfully created"
      @user.comments << @comment
    else
      flash[:alert] = "Comment can't be blank"
      redirect_to post_path(params[:post_id])
    end
  end
end
