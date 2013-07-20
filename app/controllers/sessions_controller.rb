class SessionsController < ApplicationController

  def new; end


  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "You logged in!"
    else
      flash[:alert] = "There's something wrong with your username or password"
      redirect_to login_path
    end
  end

  def show
    user = current_user
  end


  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You logged out"
  end

end
