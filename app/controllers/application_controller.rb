class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url

  # adminアクセス制限
  def admin_url
    request.fullpath.include?("/admin")
  end

  def set_current_user
    @current_user=User.find_by(id :session[:user_id])
  end

  def forbid_login_user
    if @current_user
      flash[:notice]="ログインしています"
      redirect_to root_path
    end
  end


end
