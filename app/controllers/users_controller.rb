class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  

  def create
    @user = User.new(user_params)
    if @user.save                                       #ここでbefore_actionのcreate_activation_digestが実行される。
      # @user.send_activation_email                      #このsend_activation_emailメソッドの中のaccount_activationはuser_mailerのメソッド？それともuser_mailer_previewのメソッド？
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
        )
    end
end
