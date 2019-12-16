module ReviewsHelper
  #def review_season
   # season = Review.select(:season).group.map(&:season)
    #season.each { |a| puts a.to_sym }
  #end

  def select_review
    @search_reviews = Review.all
    @search_fish = @search_reviews.fish
    @search_reviews.each do |search_review|
      @search_fish = search_review.fish
    end
  end

end
