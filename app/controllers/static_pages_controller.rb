class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @reviews = current_user.feed
    else
      @q = Review.ransack(params[:q])
      @reviews = @q.result.includes(:fish).page(params[:page]).per(20)
    end
  end

  def about 
  end

end
