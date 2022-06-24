class Public::RelationshipsController < ApplicationController

  #フォローする
  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  #フォローを外す
  def destroy
    current_customer.unfollow(params[:customer_id])
    redirect_to request.referer
  end


  def follower
    customer = Customer.find(params[:customer_id])
    @customers = customer.following_customer
    @customer = Customer.find(params[:customer_id])
  end

  def followed
    customer = Customer.find(params[:customer_id])
    @customers = customer.follower_customer
    @customer = Customer.find(params[:customer_id])
  end

end
