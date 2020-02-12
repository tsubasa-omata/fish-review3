module ReviewsHelper

  def select_review
    @search_reviews = Review.all
    @search_fish = @search_reviews.fish
    @search_reviews.each do |search_review|
      @search_fish = search_review.fish
    end
  end

  def correct_user
    @user.id == current_user.id  
  end

end
