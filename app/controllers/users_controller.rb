class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: "You're registered! Now go log in!"
    else
      render :new
    end
  end

  def show
    @user = User.find_by slug: (params[:id])
  end

private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end


