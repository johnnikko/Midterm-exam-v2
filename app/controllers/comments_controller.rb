class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params.require(:comment).permit(:content))
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to article_path(@article)
    end
  end
end
