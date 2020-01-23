module UsersHelper
  def star(review)
    '★' * review.taste_level
  end
  #application_controllerにincludeしているからどこでも呼び出せる
  def review_correct_user
    @user = User.find(params[:id])
    current_user?(@user)
  end

  def blood(review)
    review.blood? ? "有り" : "無し"
  end
end
