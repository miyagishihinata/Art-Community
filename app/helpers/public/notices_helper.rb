module Public::NoticesHelper
  def notice_form(notice)
    @visiter = notice.visiter
    @comment = nil
    @illustration = link_to illustration_path(current_user.illustration.id), users_illustration_path(notice), style:"font-weight: bold;"
    @visiter_comment = notice.comment_id
    #notice.actionがfollowかlikeかcommentか

    case notice.action
      when "follow" then
        tag.a(notice.visiter.user_name, href:users_user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.user_name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_illustration_path(notification.item_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)&.content
        tag.a(@visiter.user_name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notice.illustration_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end


end
