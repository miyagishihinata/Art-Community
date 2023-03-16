class Public::NoticesController < ApplicationController
  before_action :move_to_signed_in

  def index
    @notices = current_user.passive_notices.page(params[:page]).per(20)
    #自分の投稿に対するいいね、コメントは通知に表示しない↓
    @notices = @notices.where.not(visitor_id: current_user.id)
    @notices.where(checked: false).each do |notice|
      notice.update!(checked: true)
    end
  end

  def notice_params
    params.require(:notice).permit(:user_name, :profile_picture, :visitor_id, :visited_id, :illustration_id, :comment_id, :action)
  end

  def move_to_signed_in
    unless user_signed_in?
     #サインインしていないユーザーはトップページが表示される
     redirect_to  root_path
    end
  end

end
