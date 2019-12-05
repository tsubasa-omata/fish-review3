class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

  def thumbnail
    return self.avatar.variant(resize: '50x50')
  end
end
