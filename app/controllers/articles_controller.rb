class ArticlesController < ApplicationController
  before_action :set_articles, only: [:edit,:update,:destroy,:show]
  before_action :authenticate_user!, only: [:create,:edit,:update,:destroy,:show]
  before_action :check_user, only: [:update,:delete,:destroy]

  def index
    @articles = Article.includes(:category).page(params[:page]).per(10)

    if params[:id]
      @article = Article.find(params[:id])

      if @article.user_id != current_user.id
        flash[:danger] = "User can only edit its own articles!"
        redirect_to articles_path
      else
        @article = Article.find(params[:id]) if params[:id]
        @url = article_path(@article)
        @method = :put
      end
    else
      @article = Article.new
      @url = articles_path
      @method = :post
    end
  end

  def create
    @article = Article.create(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:success] = "Article saved!"
      redirect_to articles_path
    else
      flash[:danger] = "Article failed to save!"
      redirect_to articles_path
    end
  end

  def edit

  end

  def update
    if @article.update(article_params)
      flash[:sucsess] = "Article updated!"
      redirect_to articles_path(page: params[:page])
    else
      flash[:danger] = "Article failed to save!"
      redirect_to articles_path(id: @article.id)
    end
  end

  def destroy
    if @article.destroy
      flash[:danger] = "Article delete!"
      redirect_to articles_path
    end
  end

  def show
    @comments = @article.comments.includes(:user).all
    @comment = Comment.new
  end

  private
  def article_params
    params.require(:article).permit(:title, :category_id, :content)
  end

  def set_articles
    @article = Article.find(params[:id])
  end

  def check_user
    if @article.user_id != current_user.id
      flash[:danger] = "User can only edit its own articles!"
      redirect_to articles_path
    end
  end

end
