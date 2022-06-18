# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :customer_state, only: [:create]

  def guest_sign_in
    customer = Customer.guest
    # deviseのsign_inメソッドを使ってguestをログインさせる
    sign_in customer
    redirect_to posts_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # def after_sign_up_path_for(resource)
  #   mypage_path
  # end

  # def after_out_path_for(resource)
  #   root_path
  # end



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    mypage_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end






  # def configure_permitted_parameters
  # devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  # end

  protected
  # 退会しているかを判断するメソッド
  def customer_state
    ## 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別 trueで退会
    if @customer.valid_password?(params[:customer][:password]) && (@customer.is_deleted == true)
      # 会員ステータスが退会の場合は新規登録へ
       redirect_to new_customer_registration_path
    end
  end

end