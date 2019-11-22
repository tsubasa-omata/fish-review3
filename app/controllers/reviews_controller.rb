class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :destroy]
  def show
    @review = Review.find_by(id: params[:id])
  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find_by(id: params[:id])
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      flash[:success] = "投稿完了"
      redirect_back_or current_user
    else
      render "reviews/new"
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = "投稿を編集しました"
      redirect_to @review
    else
      render 'edit'
    end
  end

  private

      def review_params
        params.require(:review).permit( :fish_id,
                                        :taste_level,
                                        :taste_imp,
                                        :season,
                                        :fish_size,
                                        :place,
                                        :place_detail,
                                        :recipe,
                                        :preservation_period,
                                        :blood,
                                        :picture
                                        )
      end
end