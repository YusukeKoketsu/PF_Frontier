class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
      # 検索ワードはcontentで、検索対象はmodel
      @model = params[:model]
      @content = params[:content]
      if @model == 'customer'
        @records = Customer.where('nickname LIKE ?', '%'+@content+'%')
      elsif @model == 'post'
        @records = Post.where('title LIKE ?', '%'+@content+'%')
      else
        flash[:alert] = 'キーワードと検索条件を入力してください。'
        redirect_to posts_path
      end
  end

end
