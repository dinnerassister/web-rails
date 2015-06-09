class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    render :edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path, notice: 'User was successfully updated.'
    else
      @user = current_user
      render :edit
    end
  end

  def show
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end

end
