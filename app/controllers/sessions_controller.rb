class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create

    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # login is valid
      session[:user_id] = user.id
      redirect_to '/'
    else
      # login is not valid
      render :new
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
