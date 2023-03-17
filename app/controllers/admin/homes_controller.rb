class Admin::HomesController < ApplicationController
  def top
    @illustrations = Illustration.joins(:user).where("is_deleted = false").page(params[:page]).order(created_at: :desc)
  end
end
