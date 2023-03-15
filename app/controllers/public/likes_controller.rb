class Public::LikesController < ApplicationController
 before_action :is_guest_user, only: [:create, :destroy]

  def create
    @illustration = Illustration.find(params[:illustration_id])
    my_like =  @illustration.likes.find_by(user_id: current_user.id)
    #自分のいいねのみ消す
    if my_like
      my_like.destroy
    end
    like = current_user.likes.new(illustration_id: @illustration.id)
    like.like_stamp = params[:like_stamp].to_i
    like.save

    #いいね通知
    @illustration.create_notice_like!(current_user)
    redirect_to request.referer
  end

  def destroy
    illustration = Illustration.find(params[:illustration_id])
    like = current_user.likes.find_by(illustration_id: illustration.id, like_stamp: params[:like_stamp].to_i)
    like.destroy
    redirect_to illustration_path(illustration.id)
  end

  private

  def like_params
    params.require(:like).permit(:like_stamp, :illustration_id, :user_id)
  end


  def is_guest_user
    if current_user.guest?
      flash[:notice] = "ゲストユーザーはいいねできません。"
      redirect_to illustration_path(params[:illustration_id])
    end
  end

end
