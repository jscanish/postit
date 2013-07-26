class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create,]
  before_action :require_admin, except: [:show]

  def new
    @category = Category.new
  end


  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path, notice: "Category was successfully created"
    else
      render :new
    end
  end


  def show
    @category = Category.find_by slug: (params[:id])
  end


  private

  def category_params
    params.require(:category).permit!
  end

end

