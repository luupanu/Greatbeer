class SessionsController < ApplicationController
  def new
    # render login page
  end

  def create
    user = User.find_by username: params[:username]

    if user.banned
      redirect_to signin_path, notice: "You have been banned. Please contact an admin."
    elsif user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back, #{params[:username]}!"
    else
      redirect_to signin_path, notice: "Wrong username or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
