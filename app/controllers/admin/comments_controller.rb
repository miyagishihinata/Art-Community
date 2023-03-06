class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_illustration_path(params[:illustration_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:post_comment, :illustration_id, :user_id, :parent_id)
  end

end
