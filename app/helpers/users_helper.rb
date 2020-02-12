module UsersHelper
  def star(review)
    '★' * review.taste_level
   
  end
 
  def review_correct_user
    @user = User.find(params[:id])
    current_user?(@user)
  end

  def blood(review)
    review.blood? ? "有り" : "無し"
 
  end

  def guest_user?
    current_user.account_name == "@guest"
  end
end
