class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:email])

    #check if email exists in db and if password is correct
    if @user && @user.authenticate(params[:password])
      #save user id in a cookie
      session[:user_id] = @user.id
      redirect_to '/'
    else
      #if login is not valid
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
