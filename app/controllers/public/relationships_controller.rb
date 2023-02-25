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
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page])
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page])
  end

  private

  def is_guest_user
    redirect_to user_path(params[:user_id]) if current_user.guest?
    flash[:notice] = "ゲストユーザーはフォローできません"
  end


end

