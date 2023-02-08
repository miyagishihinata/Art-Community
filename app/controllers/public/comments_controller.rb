class Public::CommentsController < ApplicationController
  def create
    illustration = Illustration.find(params[:illustration_id])
    post_comment = current_user.comments.new(comment_params)
    post_comment.illustration_id = illustration.id
    post_comment.save
    redirect_to illustration_path(illustration.id)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to illustration_path(params[:illustration_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:post_comment)
  end

end
