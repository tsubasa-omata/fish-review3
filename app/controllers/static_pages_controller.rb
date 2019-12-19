class StaticPagesController < ApplicationController
  def home
    if logged_in?
      #@micropost  = current_user.microposts.build
      @feed_items = current_user.feed
    end
    @q = Review.ransack(params[:q])
    @reviews = @q.result.includes(:fish).page(params[:page]).per(20)
  end
end
