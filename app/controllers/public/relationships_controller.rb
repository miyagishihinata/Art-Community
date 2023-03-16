class Public::RelationshipsController < ApplicationController
  before_action :is_guest_user, only: [:create, :destroy]

  # フォローするとき
  def create
    current_user.follow(params[:user_id])

    # フォロー通知
    @user = User.find(params[:user_id])
    @user.create_notice_follow!(current_user)
    redirect_to request.referer
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.joins(:user).where("is_deleted = false").page(params[:page]).order(created_at: :desc)
  end

  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.joins(:user).where("is_deleted = false").page(params[:page]).order(created_at: :desc)
  end

  private

  def relationship_params
    params.require(:relationship).permit(:user_name, :user_id, :profile_image, :follower_id, :followed_id)
  end

  def is_guest_user
    if current_user.guest?
      flash[:notice] = "ゲストユーザーはフォローできません"
      redirect_to user_path(params[:user_id])
    end
  end



end

