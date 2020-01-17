class CommentsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @review }
        format.js
      else
        render :shared/error, status: :unprocessable_entity
        format.html { redirect_to @review }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @review }
      format.js
    end
  end

private
    def comment_params
      params.require(:comment).permit(:content,
                                      :review_id,
                                      :user_id
                                      )
    end
end