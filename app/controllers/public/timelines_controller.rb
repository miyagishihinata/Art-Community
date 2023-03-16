class Public::TimelinesController < ApplicationController
  before_action :move_to_signed_in

  def index
    @illustrations = Illustration.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc).page(params[:page])
    @users = User.where(user_id: [current_user.id, *current_user.following_ids])
  end

  private

  def timeline_params
    params.require(:timeline).permit(:user_name, :title, :profile_picture, :image)
  end

  def move_to_signed_in
    unless user_signed_in?
     #サインインしていないユーザーはトップページが表示される
     redirect_to  root_path
    end
  end


end

