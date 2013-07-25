class CommentsController < ApplicationController
  before_action :require_user, only: [:create]

   def create
    @user = current_user
    @post = Post.find_by slug: (params[:post_id])
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

  def vote
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.js do
        if current_user.already_voted(@comment)
          render js: "alert('You can only vote on a comment once!')"
        else
          Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
          format.js
        end
      end
    end
  end
end
