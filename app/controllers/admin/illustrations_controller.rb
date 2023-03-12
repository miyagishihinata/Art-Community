class Admin::IllustrationsController < ApplicationController
  def show
    @illustration = Illustration.find(params[:id])
    @comments = @illustration.comments.where(parent_id: nil).page(params[:page]).order(created_at: :desc)
    @comment = Comment.new
    @comment_reply = Comment.new
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end

  def update
    illustration = Illustration.find(params[:id])
    illustration.update(illustration_params)
    redirect_to admin_illustration_path(illustration.id)
  end

  def destroy
    illustration = Illustration.find(params[:id])
    illustration.destroy
    redirect_to admin_user_path(@user.id)
  end

  private

  def illustration_params
    params.require(:illustration).permit(:user_name, :profile_image, :title, :introduction, :image, :user_id, :post_comment, :parent_id)
  end

end
