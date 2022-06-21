class ApplicationController < ActionController::Base

# ゲストログインの機能制限の為の定義
  def guest_sign_in
    if current_customer.email == "guest@example.com"
       redirect_to request.referer, notice: "ゲストでは、使用できません"
    end
  end

end
