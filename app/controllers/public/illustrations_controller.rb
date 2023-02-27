class Public::IllustrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_guest_user, only: [:new, :create]

  def index
    @illustrations = Illustration.page(params[:page]).order(created_at: :desc)
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
    @comment = Comment.new
    @comment_reply = Comment.new #コメントに対する返信用の変数
    @user = current_user
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
    redirect_to user_path(current_user.id)
  end

  private

  def is_guest_user
    redirect_to user_path(current_user.id) if current_user.guest?
    flash[:notice] = "ゲストユーザーはイラスト投稿を行うことはできません。"
  end

  def illustration_params
    params.require(:illustration).permit(:user_name, :profile_image, :title, :introduction, :image, :user_id)
  end

end
