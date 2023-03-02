class Public::CommentsController < ApplicationController
 before_action :is_guest_user, only: [:create, :destroy]

  def create
    illustration = Illustration.find(params[:illustration_id])
    post_comment = current_user.comments.new(comment_params)
    post_comment.illustration_id = illustration.id

    if illustration = Illustration.find(params[:illustration_id])
      post_comment.save
      illustration.create_notice_comment!(current_user, post_comment.id)
      flash[:notice] = "コメントの投稿に成功しました"
      redirect_to illustration_path(params[:illustration_id])

    else
      flash[:notice] = "コメントの投稿に失敗しました"
      render 'illustrations/show'
    end
  end


  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to illustration_path(params[:illustration_id])
  end

  private

  def is_guest_user
    flash[:notice] = "ゲストユーザーはコメントの投稿を行うことはできません。"
    redirect_to illustration_path(params[:illustration_id]) if current_user.guest?
  end


  def comment_params
    params.require(:comment).permit(:post_comment, :illustration_id, :user_id, :parent_id)
  end

end

