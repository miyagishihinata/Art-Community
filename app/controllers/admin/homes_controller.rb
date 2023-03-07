class Admin::HomesController < ApplicationController
  def top
    @illustrations = Illustration.page(params[:page]).order(created_at: :desc)
  end
end
