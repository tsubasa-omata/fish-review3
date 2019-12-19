module FishesHelper
 #魚に属する投稿が持っている:seasonの値を配列にしてわたす。
def fish_season
  @fish = Fish.find_by(id: params[:id])
  @fish.reviews(:season)
end

end