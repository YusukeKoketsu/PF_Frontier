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

  #ログイン会員フォロワー一覧
  def follower
    customer = current_customer
    @customers = customer.following_customer
  end

  #ログイン会員フォロー中一覧
  def followed
    customer = current_customer
    @customers = customer.follower_customer
  end

end
