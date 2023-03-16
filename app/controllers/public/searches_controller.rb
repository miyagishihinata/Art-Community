class Public::SearchesController < ApplicationController
  before_action :move_to_signed_in

  def search
    @illustrations = Illustration.search(params[:keyword])
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def index
    @illustrations = Illustration.search(params[:keyword]).page(params[:page]).order(created_at: :desc)
    @users = User.search(params[:keyword]).page(params[:page])
    @search_word = params[:keyword]
  end

  private

  def search_params
    params.require(:user).permit(:user_name, :self_introduction, :profile_picture, :image)
  end

  def move_to_signed_in
    unless user_signed_in?
     #サインインしていないユーザーはトップページが表示される
     redirect_to  root_path
    end
  end

end
