class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :guest_sign_in, only: [:index, :create, :destroy]


  # ログイン会員のコメント一覧
  def index
    @post_comments = current_customer.post_comments.page(params[:page])
  end

  def create
    @post = Post.find(params[:post_id])
    post_comment = current_customer.post_comments.new(post_comment_params)
    post_comment.post_id = @post.id
    post_comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
     post_comment = @post.post_comments.find(params[:id])
     post_comment.destroy
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
