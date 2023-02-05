class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    #@post_llustration = @user.post_llustration.page(params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  
  def user_params
    params.require(:user).permit(:user_name, :profile_image, :is_deleted)
  end
  
end
