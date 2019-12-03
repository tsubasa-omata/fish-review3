module UsersHelper
  def star(review)
    if review.taste_level == 1
      return "★"
    elsif review.taste_level == 2
      return "★★"
    elsif review.taste_level == 3
      return "★★★"
    elsif review.taste_level == 4
      return "★★★★"
    elsif review.taste_level == 5
      return "★★★★★"
    end
  end
end
