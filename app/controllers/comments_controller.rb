class CommentsController < ApplicationController
  before_action :set_review, only: %i[create destroy]

  def create
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user
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
    @comment = @review.comments.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @review }
      format.js
    end
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :review_id, :user_id)
  end
end