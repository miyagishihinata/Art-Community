class Public::IllustrationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @illustrations = Illustration.page(params[:page])
  end

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
    @user = User.find(params[:id])
    @comment = Comment.new
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
    params.require(:illustration).permit(:user_name, :profile_image, :title, :introduction, :image, :user_id)
  end

end
