module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end
  
  def remember(user) #
    user.remember    #これはuserモデルで記述しているrememberメソッドをよんでいる？
    cookies.permanent.signed[:user_id] = user.id  #user.idをcookiesのuser_idの属性に代入している
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if (user_id = session[:user_id])                        #sessionのハッシュの中に入っているuser_idの値をローカル変数user_idに代入してそれを評価している
    @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])              #sessionにuser_idがなかった場合、cookiesのuser_idをローカル変数user_idに代入して評価している
     user = User.find_by(id: user_id)                       #userインスタンスをUserのDBから取得する
     if user && user.authenticated?(:remember, cookies[:remember_token])
       log_in user                                          #sessionを復元
       @current_user = user
     end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget   #userモデルのforgetメソッド
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  
end
