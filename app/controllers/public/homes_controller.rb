class Public::HomesController < ApplicationController
  def top
    @illustrations = Illustration.order('id DESC').limit(10)
  end

  def illustration_params
    params.require(:home).permit(:image)
  end
  
  # ゲストユーザー
  def guest_sign_in
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲスト"
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
