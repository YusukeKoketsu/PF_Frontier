class Public::SearchesController < ApplicationController

  def search
      # 入力、選択された値をparamsで受け取って@~に代入
      # 検索ワードはcontentで、検索対象はmodelで、検索方法はmethod
      @model = params[:model]
      @content = params[:content]
      if @model == 'customer'
        @records = Customer.where('nickname LIKE ?', '%'+@content+'%')
      elsif @model == 'post'
        @records = Post.where('title LIKE ?', '%'+@content+'%')
      else
        redirect_to posts_path, notice: "キーワードと検索条件を入力してください"
      end
  end

end
