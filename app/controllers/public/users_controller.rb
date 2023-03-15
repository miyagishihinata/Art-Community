class Public::UsersController < ApplicationController
  before_action :forbid_login_user, {only: [:user_name, :email, :create, :login_form, :login]}
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :is_guest_user, only: [:edit, :update]

  #ユーザー詳細画面
  def show
    @user = User.find(params[:id])
    @illustrations = @user.illustrations.page(params[:page]).order(created_at: :desc)
  end

  #いいね一覧
  def likes
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:illustration_id)
    @like_posts = Illustration.where(id: likes).page(params[:page]).order(created_at: :desc)
    @illustration = Illustration.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    bypass_sign_in @user if @user.valid?
    flash[:notice] = "ユーザー情報を更新しました。"
    redirect_to user_path(@user.id)
  end


  def withdrawl
    @user = current_user
   #ゲストユーザー
   if @user.email == 'guest@example.com'
      reset_session
      redirect_to root_path
   #ユーザー退会
   else
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
   end
  end


  private

  def user_params
    params.require(:user).permit(:user_name,  :self_introduction, :is_deleted, :email, :profile_picture, :password, :password_confirmation)
  end


  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(user_id)
    end
  end

  def is_guest_user
    if current_user.guest?
      flash[:notice] = "ゲストユーザーはユーザー編集を行うことはできません。"
      redirect_to user_path(current_user.id)
    end
  end


end
