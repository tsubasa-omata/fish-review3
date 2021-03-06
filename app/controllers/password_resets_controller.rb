class PasswordResetsController < ApplicationController

  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase) 
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールをお送りしました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが登録されていません"
      render 'new'
    end
  end

  def update
    if params[:user][:password].empty?                  
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)         
      log_in @user
      flash[:success] = "パスワードが再設定されました"
      redirect_to @user
    else
      render 'edit'                                     
    end
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end

      def get_user
        @user = User.find_by(email: params[:email])
      end

      # 正しいユーザーかどうか確認する
      def valid_user
        unless (@user && @user.activated? &&
                @user.authenticated?(:reset, params[:id]))
          redirect_to root_url
        end
      end

      def check_expiration
        if @user.password_reset_expired?
          flash[:danger] = "メールの有効期限が切れています　パスワード再設定を再度行ってください"
          redirect_to new_password_reset_url
        end
      end
end
