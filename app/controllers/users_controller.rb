class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    authorize User
  end

  def update
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def secure_params
    params.require(:user).permit(:role)
  end
end
