class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :guest_sign_in, only: [:mypage, :edit, :update, :unsubscribe, :withdrawal]
  # url直打ち設定
  before_action :ensure_correct_customer, only: [:mypage, :edit, :update, :withdrawal, :unsubscribe]


  def mypage
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = '情報を更新しました'
      redirect_to mypage_path
    else
      render 'edit'
    end
  end

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  # 退会画面表示
  def unsubscribe
    @customer = Customer.find(params[:id])
  end

  # 退会処理
  def withdrawal
    @customer = Customer.find(params[:id])
    # trueで退会  tureになっていたら、update
    @customer.update(is_deleted: true)
    reset_session
    flash[:alert] = '退会処理をいたしました'
    redirect_to new_customer_session_path
  end


  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :nickname, :profile_image, :email, :is_deleted)
  end

  # url直打ち設定
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to root_path(current_customer)
    end
  end

end
