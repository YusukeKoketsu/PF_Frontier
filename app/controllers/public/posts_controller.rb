class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :guest_sign_in, only: [:new, :create, :destroy, :edit, :update, :post_list]
  # url直打ち設定
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post.customer_id = current_customer.id
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to post_path(@post.id)
      flash[:notice] = '新規投稿しました'
    else
      render 'new'
    end
  end

  def index
    @categories = Category.all
    if params[:latest]
      @posts = Post.latest.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    elsif params[:rate]
      @posts = Post.star_count.page(params[:page])
    else
      @posts = Post.page(params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to post_path
       flash[:notice] = '投稿情報を更新しました'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = '投稿を削除しました'
    redirect_to customer_post_list_path(@post.customer_id)
  end

  def hashtag
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts.page(params[:page])
  end

 # ログイン会員の投稿一覧
  def post_list
    @posts = current_customer.posts.page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction, :category_id, :rate)
  end

  # url直打ち設定
  def ensure_correct_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to root_path(current_customer)
    end
  end

end
