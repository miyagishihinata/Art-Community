class Admin::UsersController < ApplicationController
  def index
    @user = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @llustration = @user.llustration.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end


  def user_params
    params.require(:user).permit(:user_name, :profile_image, :self_introduction, :is_deleted, :image)
  end

end
