class Public::TimelinesController < ApplicationController
  def index
    @illustrations = Illustration.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc).page(params[:page])
    @users = User.where(user_id: [current_user.id, *current_user.following_ids])
  end
end
