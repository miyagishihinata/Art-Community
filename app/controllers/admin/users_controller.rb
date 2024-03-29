class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @illustrations = @user.illustrations.page(params[:page]).order(created_at: :desc)
  end

  #いいね一覧
  def likes
    @user = User.find(params[:id])
    @likes= Like.where(user_id: @user.id).joins(:user).where("is_deleted = false").pluck(:illustration_id)
    @like_illustrations = Illustration.where(id: @likes).joins(:user).where("is_deleted = false").page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    flash[:notice] = "ユーザー情報を更新しました。"
    redirect_to admin_user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :self_introduction, :is_deleted, :email, :profile_picture)
  end


end
