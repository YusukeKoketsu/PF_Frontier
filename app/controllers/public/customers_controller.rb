class Public::CustomersController < ApplicationController

  def mypage
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to mypage_path
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
