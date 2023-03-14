class Public::IllustrationsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
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
    if @illustration.save
      redirect_to illustration_path(@illustration.id)
    else
      flash[:notice] = "投稿に失敗しました。"
      render :new
    end
  end

  def show
    @illustration = Illustration.find(params[:id])
    @comments = @illustration.comments.where(parent_id: nil).page(params[:page]).order(created_at: :desc)
    @comment = Comment.new
    @comment_reply = Comment.new
    @user = current_user
  end

  def edit
    @illustration = Illustration.find(params[:id])
  end

  def update
    illustration = Illustration.find(params[:id])
    illustration.update(illustration_params)
    flash[:notice] = "イラスト情報を変更しました。"
    redirect_to illustration_path(illustration.id)
  end

  def destroy
    illustration = Illustration.find(params[:id])
    illustration.destroy
    flash[:notice] = "イラストを削除しました。"
    redirect_to user_path(current_user.id)
  end

  private

  def illustration_params
    params.require(:illustration).permit(:user_name, :profile_image, :title, :introduction, :image, :user_id, :post_comment, :parent_id)
  end
  
  
  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(@user.id)
    end
  end


  def is_guest_user
    if current_user.guest?
      flash[:notice] = "ゲストユーザーはイラスト投稿を行うことはできません。"
      redirect_to user_path(current_user.id)
    end
  end


end
