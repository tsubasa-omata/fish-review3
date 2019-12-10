class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update,:destroy,:following,:followers]
  before_action :correct_user,   only: [:edit, :update]
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
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render "new"
  end
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "プロフィールを編集しました"
    redirect_to @user
  else
    render 'edit'
  end
end

def following
  @title = "フォロ一覧"
  @user  = User.find(params[:id])
  @users = @user.following
  render 'show_follow2'
end

def followers
  @title = "フォロワー一覧"
  @user  = User.find(params[:id])
  @users = @user.followers
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

end
