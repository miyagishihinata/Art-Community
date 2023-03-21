class Admin::RelationshipsController < ApplicationController

  # フォロー一覧
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).order(created_at: :desc)
  end

  # フォロワー一覧
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).order(created_at: :desc)
  end

  private

  def relationship_params
    params.require(:relationship).permit(:user_name, :user_id, :profile_image, :follower_id, :followed_id)
  end

end
