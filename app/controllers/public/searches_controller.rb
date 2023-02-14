class Public::SearchesController < ApplicationController
  def search
    @illustrations = Illustration.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

end
