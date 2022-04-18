class Admin::Base < ApplicationController
  # before_action :authorize

  private def current_administrator
    if session[:administrator_id]
      @current_administrator_id ||=
        Administrator.find_by(id: session[:administrator_id])
    end
  end

  helper_method :current_administrator

  private def authorize
    unless current_administrator
      flash.alert = "管理者としてログインしてください"

      # 本当は管理者のログインに飛ばすけど作ってないから省略
      redirect_to :staff_login
    end
  end
end