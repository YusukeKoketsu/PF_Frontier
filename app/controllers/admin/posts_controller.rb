class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
  end

  def post_list
    @customer = Customer.find(params[:customer_id])
    @posts = @customer.posts.page(params[:page])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = '投稿の情報を更新しました。'
      redirect_to admin_post_path
    else
      render 'edit'
    end
  end


  def hashtag
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts.page(params[:page])
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = '投稿を削除しました。'
    redirect_to admin_customer_post_list_path(@post.customer.id)
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction, :category_id, :rate)
  end

end
