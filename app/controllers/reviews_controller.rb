class ReviewsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :destroy, :index, :update]
  before_action :correct_user,   only: :destroy
  
  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result.includes(:fish).page(params[:page]).per(20)
  end
  
  def show
    @review = Review.find(params[:id])
    @user = User.find_by(id: @review.user_id)
    @comment = Comment.new
    @comments = @review.comments

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

  def destroy
    @review.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
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
                                        :avatar
                                        )
      end

      def correct_user
        @review = current_user.reviews.find_by(id: params[:id])
        redirect_to root_url if @review.nil?
      end
end