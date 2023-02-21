class Public::LikesController < ApplicationController
  def create
    @illustration = Illustration.find(params[:illustration_id])
    like = current_user.likes.new(illustration_id: @illustration.id)
    like.save
    
    #いいね通知
    @illustration.create_notice_like!(current_user)
    redirect_to request.referer

  end

  def destroy
    illustration = Illustration.find(params[:illustration_id])
    like = current_user.likes.find_by(illustration_id: illustration.id)
    like.destroy
    redirect_to illustration_path(illustration.id)
  end


end
