class Admin::SearchesController < ApplicationController
  def search
    @illustrations = Illustration.search(params[:keyword])
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render "admin/searches/index"
  end

  def index
    @illustrations = Illustration.search(params[:keyword]).page(params[:page]).order(created_at: :desc)
    @users = User.search(params[:keyword]).page(params[:page])
    @search_word = params[:keyword]
  end

end
