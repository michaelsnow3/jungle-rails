class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      puts "user id: #{@user.id}"
      session[:user_id] = @user.id
      puts session
      redirect_to '/'
    else
      render :new
    end
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
