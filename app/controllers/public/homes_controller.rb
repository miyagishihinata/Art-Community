class Public::HomesController < ApplicationController
  before_action :forbid_login_user, {only: [:top]}

  def top
    @illustrations = Illustration.order('id DESC').limit(10)
  end

  def illustration_params
    params.require(:home).permit(:image).order(created_at: :desc)
  end

  # ゲストユーザー
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲスト"
    end
    sign_in user
    flash[:notice] = 'ゲストユーザーとしてログインしました。'
    redirect_to illustrations_path
  end

end
