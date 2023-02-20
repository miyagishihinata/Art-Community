class Public::LikesController < ApplicationController
  def create
    like = current_user.likes.new(illustration_id: @illustration.id)
    like.save
    @illustration = Illustration.find(params[:illustration_id])
    #通知の作成
    @illustration.create_notice_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    illustration = Illustration.find(params[:illustration_id])
    like = current_user.likes.find_by(illustration_id: illustration.id)
    like.destroy
    redirect_to illustration_path(illustration.id)
  end


end
