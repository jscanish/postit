class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "You're registered!"
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


