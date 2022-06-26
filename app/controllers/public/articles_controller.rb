class Public::ArticlesController < ApplicationController
before_action :authenticate_customer!

  def show
    @article = Article.find(params[:id])
  end

end
