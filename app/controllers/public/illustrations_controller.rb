class Public::IllustrationsController < ApplicationController
  def new
    @illustration = Illustration.new
  end

  def create
    @illustration = Illustration.new(illustration_params)
    @illustration.user_id = current_user.id
    @illustration.save
    redirect_to illustration_path(@illustration.id)
  end

  def show
    @illustration = Illustration.find(params[:id])
    #@post_comment = PostComment.new
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end

  def update
    illustration = Illustration.find(params[:id])
    illustration.update(illustration_params)
    redirect_to illustration_path(illustration.id)
  end

  def destroy
    illustration = Illustration.find(params[:id])
    illustration.destroy
    redirect_to user_path(@user.id)
  end

  private

  def illustration_params
    params.require(:illustration).permit(:user_name, :profile_image, :title, :introduction, :image)
  end

end
