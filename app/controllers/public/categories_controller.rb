class Public::CategoriesController < ApplicationController
  before_action :authenticate_customer!

  def show
    @category = Category.find(params[:id])
  end

end
