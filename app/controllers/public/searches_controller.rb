class Public::SearchesController < ApplicationController
  def search
    @illustrations = Illustration.search(params[:keyword])
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def index
    @illustrations = Illustration.search(params[:keyword])
    @users = User.search(params[:keyword])
    @search_word = params[:keyword]
  end


end
