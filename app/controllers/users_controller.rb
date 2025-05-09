class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      # Sign in the user after successful registration
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome to the circus! 🎪"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :profile_picture, :identity)
  end
end 