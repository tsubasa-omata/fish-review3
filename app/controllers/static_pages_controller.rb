class StaticPagesController < ApplicationController
  def home
    if logged_in?
      #@micropost  = current_user.microposts.build
      @reviews = current_user.feed
    else
      @q = Review.ransack(params[:q])
      @reviews = @q.result.includes(:fish).page(params[:page]).per(20)
    end
  end

  def about
    
  end

end
