class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :destroy]
  def show
  end

  def new
    @review = Review.new
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
