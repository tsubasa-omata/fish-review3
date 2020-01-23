class LikesController < ApplicationController
  before_action :set_review, only: %i[create destroy]
  before_action :set_like, only: %i[destroy]

  def index
    @likes = current_user.likes
  end

  def create
    @like = current_user.likes.build(review: @review)
    if @like.save
      render :save
    else
      render :save_error
    end
  end
  
  def destroy
    if @like.destroy
      render :save
    else
      render :save_error
    end
  end

private
    def set_review
      @review = Review.find(params[:review_id])
    end

    def set_like
      @like = @review.likes.find(params[:id])
    end
end
