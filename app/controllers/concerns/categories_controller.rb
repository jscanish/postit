class CategoriesController < ApplicationController

  def index
    @categories = Category.all(order: "created_at DESC")
  end


  def new
    @category = Category.new
  end


  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category was successfully created"
    else
      render :new
    end
  end


  def show
    @category = Category.find(params[:id])
    @post = Post.find(params[:id])
  end


  private

  def category_params
    params.require(:category).permit!
  end

end



