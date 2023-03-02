class Public::NoticesController < ApplicationController
  def index
    @notices = current_user.passive_notices.page(params[:page]).per(20)
    #自分の投稿に対するいいね、コメントは通知に表示しない↓
    @notices = @notices.where.not(visitor_id: current_user.id)
    @notices.where(checked: false).each do |notice|
      notice.update!(checked: true)
    end
  end
end
