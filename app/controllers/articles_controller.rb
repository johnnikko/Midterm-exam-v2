class ArticlesController < ApplicationController
  before_action :set_articles, only: [:edit,:update,:destroy,:show]
  def index
    @articles = Article.includes(:category).page(params[:page]).per(10)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:success] = "Article saved!"
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
    if @article.user_id != current_user.id
      flash[:danger] = "User can only edit its own articles!"
      redirect_to articles_path
    end
  end

  def update
    if @article.update(article_params)
      flash[:sucsess] = "Article updated!"
      redirect_to articles_path(page: params[:page])
    else
      render :edit
    end
  end

  def destroy
    if @article.user_id != current_user.id
      flash[:danger] = "User can only edit its own articles!"
      redirect_to articles_path
    else
      if @article.destroy
        flash[:danger] = "Article delete!"
        redirect_to articles_path
      end
    end
  end

  def show
    @comments = @article.comments.includes(:user).all
  end

  private
  def article_params
    params.require(:article).permit(:title, :category_id, :content)
  end

  def set_articles
    @article = Article.find(params[:id])
  end
end
