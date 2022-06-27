class Public::HomesController < ApplicationController
before_action :authenticate_customer!

  def top
    @articles = Article.order(created_at: :desc).page(params[:page])
  end

end
