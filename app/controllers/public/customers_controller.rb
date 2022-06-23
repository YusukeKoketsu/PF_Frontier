class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :guest_sign_in, only: [:mypage, :edit, :update, :unsubscribe, :withdrawal]

  def mypage
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to mypage_path(current_customer)
    else
      render 'edit'
    end
  end

  def index
    @customers = Customer.all
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
    # flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :nickname, :profile_image, :email, :is_deleted)
  end

end
