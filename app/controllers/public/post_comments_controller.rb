class Public::PostCommentsController < ApplicationController
  before_action :authenticate_customer!
  before_action :guest_sign_in, only: [:index, :create, :destroy]


  # ログイン会員のコメント一覧
  def index
    @post_comments = current_customer.post_comments.page(params[:page])
  end

  def create
    post = Post.find(params[:post_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
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
