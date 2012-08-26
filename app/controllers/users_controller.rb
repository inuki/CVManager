class UsersController < ApplicationController
  def create
    @user = User.new
    @user.username = params[:username]
    @user.email = params[:email]
    @user.password = params[:password]

    if @user.save
      session[:user_id] = user.id
      redirect_to root_path, notice: "Signed up!"
    else
      redirect_to new_session_path, alert: "Something goes wrong!"
    end
  end
end
