class Public::HomesController < ApplicationController
before_action :authenticate_customer!

  def top
    @articles = Article.page(params[:page])
  end

end
