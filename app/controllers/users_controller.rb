class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update,:destroy,:following,:followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @reviews = @user.reviews.order(:created_at).page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
    @title = "フォロ一 一覧"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow2'
  end

  def followers
    @title = "フォロワー 一覧"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow2'
  end

private

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
