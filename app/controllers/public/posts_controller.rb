class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @post.customer_id = current_customer.id

  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render 'new'
    end
  end

  def index
    @categories = Category.all
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:rate]
      @posts = Post.star_count
    else
     @posts = Post.all
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
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def hashtag
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts
  end

 # ログイン会員の投稿一覧
  def post_list
    @posts = current_customer.posts
  end

  private

  def post_params
    params.require(:post).permit(:image, :title, :introduction, :category_id, :rate)
  end

end
