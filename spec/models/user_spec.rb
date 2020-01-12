require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  context " ユーザーが正しい場合 " do
    it " 正しい値が入っている場合 " do
      expect(@user).to be_valid
    end
  end

  context " nameについて " do
    it " 空白の場合 " do
      @user.name = " "
      expect(@user).to be_invalid
    end
    it " 10文字以上の場合 " do
      @user.name =  "a" * 11 
      expect(@user).to be_invalid
    end
  end

  context " account_nameについて " do
    it " 空白の場合 " do
      @user.account_name = " "
      expect(@user).to be_invalid
    end
    it " 11文字以上の場合無効か " do
      @user.account_name = "a" * 11
      expect(@user).to be_invalid
    end
    it " 一意性が正しく機能しているか " do
      duplicate_user = @user.dup
      duplicate_user.account_name = @user.account_name.upcase
      @user.save!
      expect(duplicate_user).to be_invalid
    end

  end

  context " emailについて " do
    it " emailが空白の場合 " do
      @user.email = " "
      expect(@user).to be_invalid
    end
    it " 一意性が正しく機能しているか " do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save!
      expect(duplicate_user).to be_invalid
    end
    it " 正規表現のvalidationが機能しているか " do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
      end
    end
  end

  context " profについて " do
    it " 101文字以上の場合無効か " do
      @user.prof = "a" * 101
      expect(@user).to be_invalid
    end
  end

  context " passwordについて " do
    it " 空白になっていないか " do
      @user.password = @user.password_confirmation = " "
      expect(@user).to be_invalid
    end
    it " 6文字以下の場合無効か " do
      @user.password = @user.password_confirmation = "a" * 5 
      expect(@user).to be_invalid
    end
    it " 11文字以上の場合無効か " do
      @user.password = @user.password_confirmation = "a" * 11 
      expect(@user).to be_invalid
    end
  end
  
end
