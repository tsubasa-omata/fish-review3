module UsersHelper
  def star(review)
    '★' * review.taste_level
   # if review.taste_level == 1
   #   return "★"
   # elsif review.taste_level == 2
   #   return "★★"
   #elsif review.taste_level == 3
   #   return "★★★"
   # elsif review.taste_level == 4
   #   return "★★★★"
   # elsif review.taste_level == 5
   #   return "★★★★★"
   # end
  end
  #application_controllerにincludeしているからどこでも呼び出せる
  def review_correct_user
    @user = User.find(params[:id])
    current_user?(@user)
  end

  def blood(review)
    review.blood? ? "有り" : "無し"
  #  if review.blood == true
  #    return "有り"
  #  else
  #    return "無し"
  #  end
  end

  def guest_user?
    current_user.account_name == "@guest"
  end
end
