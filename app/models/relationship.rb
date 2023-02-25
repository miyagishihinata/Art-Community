class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  #フォロー通知
  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    @user.create_notice_follow!(current_user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  # ゲストユーザーの判別
  def guest?
    email == 'guest@example.com'
  end

end
