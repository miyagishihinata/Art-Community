class Admin::HomesController < ApplicationController
  def top
    @illustrations = Illustration.page(params[:page])
  end
end
