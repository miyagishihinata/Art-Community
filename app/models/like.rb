class Like < ApplicationRecord
  belongs_to :user
  belongs_to :illustration
  
  enum like_stamps:{smile: 0, heart:1, cry:2}

  #いいね通知
  def create
    @like = current_user.likes.build(like_params)
    @illustration = @like.post
    @like.save
    illustration = Illustration.find(params[:post_id])
    illustration.create_notice_like!(current_user)
    respond_to :js
  end
  
  
end
