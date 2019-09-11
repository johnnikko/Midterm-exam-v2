class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @article = Article.find(params[:article_id])
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params.require(:comment).permit(:content))
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to articles_path
    else
      render :new
    end
  end
end
