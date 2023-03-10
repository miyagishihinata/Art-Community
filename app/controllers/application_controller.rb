class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  def set_current_user
    @current_user=User.find_by(id :session[:user_id])
  end

  def autheniticate_user
    if @current_user==nil
      flash[:notice]="ログインが必要です"
      redirect_to root_path
    end
  end

end
