class Public::SearchesController < ApplicationController

  def search
      # 入力、選択された値をparamsで受け取って@~に代入
      # 検索ワードはcontentで、検索対象はmodelで、検索方法はmethod
      @model = params[:model]
      @content = params[:content]
      @method = params[:method]
      if @model == 'customer'
        @records = Customer.search_for(@content,@method)
      else
        @records = Post.search_for(@content,@method)
      end
  end

end
