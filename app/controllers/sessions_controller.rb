class SessionsController < ApplicationController

  def new
  end

  def create
    @user.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to 'root'
    else 
      redirect_to 'user/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to 'user/login'
  end

end
