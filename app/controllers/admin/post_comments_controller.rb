class Admin::PostCommentsController < ApplicationController

# 会員のコメント一覧
  def index
    @customer = Customer.find(params[:customer_id])
    @post_comments = @customer.post_comments
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
