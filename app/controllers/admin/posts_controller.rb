class Admin::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
  end

  def post_list
    @customer = Customer.find(params[:customer_id])
    @posts = @customer.posts
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_post_path
    else
      render 'edit'
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_customer_post_list_path(@post.customer.id)
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction, :category_id, :rate)
  end

end
