class UsersController < ApplicationController
   def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Thank you for signing up!"
      session[:remember_token] = @user.id
    else
      raise @user.errors.inspect	
      render 'new'
    end
  end

  protected
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
