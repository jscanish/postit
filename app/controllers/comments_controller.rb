class CommentsController < ApplicationController


   def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit!)

    if @comment.save
      redirect_to @post, notice: "Comment successfully created"
    else
      flash[:alert] = "Comment can't be blank"
      redirect_to post_path(params[:post_id])
    end
  end
end
