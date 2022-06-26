class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  before_action :guest_sign_in, only: [:show, :create, :destroy]

 # ログイン会員のいいねページ
  def show
    @favorites = current_customer.favorites.page(params[:page])
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end

end
