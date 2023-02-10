class Admin::IllustrationsController < ApplicationController
  def show
    @illustration = Illustration.find(params[:id])
    @comment = Comment.new
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
    params.require(:illustration).permit(:title, :introduction, :image)
  end

end
