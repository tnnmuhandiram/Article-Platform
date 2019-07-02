class ArticleController < ApplicationController

  def show
    @article = Article.find(params[:article_id])
    render :partial => '/components/article/show', :formats => [:html]
  end

  def create
  end
end
