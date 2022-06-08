class Admin::ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to admin_articles_path
    else
      render 'new'
    end
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to admin_article_path
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(:image, :title, :introduction)
  end

end
