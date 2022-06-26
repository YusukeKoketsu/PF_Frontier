class ApplicationController < ActionController::Base

# ゲストログインの機能制限の為の定義
  def guest_sign_in
    if current_customer.email == "guest@example.com"
      flash[:alert] = 'ゲストでは、使用できません'
       redirect_to request.referer
    end
  end

end
