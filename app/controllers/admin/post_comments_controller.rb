class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

# 会員のコメント一覧
  def index
    @customer = Customer.find(params[:customer_id])
    @post_comments = @customer.post_comments.page(params[:page])
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
