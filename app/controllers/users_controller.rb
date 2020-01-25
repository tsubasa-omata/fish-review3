class UsersController < ApplicationController
  before_action :logged_in_user,      only: [:index,:edit, :update,:destroy,:following,:followers]
  before_action :correct_user,        only: [:edit, :update]
  before_action :admin_user,          only: :destroy
  before_action :set_user,            only: [:show, :edit, :update, :following, :followers ]
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
  end
  
  def show
    @reviews = @user.reviews.order(:created_at).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.account_name = "@" + @user.account_name
    if @user.save                                       #ここでbefore_actionのcreate_activation_digestが実行される。
      @user.send_activation_email                      #このsend_activation_emailメソッドの中のaccount_activationはuser_mailerのメソッド？それともuser_mailer_previewのメソッド？
      flash[:info] = "メールを確認してアカウントを有効化して下さい"
      redirect_to root_url
    else
      render "new"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def edit
    @account_name = @user.account_name
    @account_name.slice!(0) 
    @account_name
  end

  def update
    if @user.account_name == "@guest"
      redirect_to @user
    else
      if @user.update_attributes(user_params)
        flash[:success] = "プロフィールを編集しました"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  def following
    @title = "フォロ一 "
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow2'
  end

  def followers
    @title = "フォロワー "
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow2'
  end

private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(
            :name,
            :account_name,
            :email,
            :prof,
            :picture ,
            :password ,
            :password_confirmation ,
            :avatar
        )
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
