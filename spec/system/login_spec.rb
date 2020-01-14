require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
    
    it "有効な情報の場合、ログインに成功すること" do
      user = FactoryBot.create(:user, name: 'sample',
        email: 'sample@example.com',
        password: 'password')
      visit login_path
      fill_in "メールアドレス", with: "sample@example.com"
      fill_in "パスワード", with: "password"
      click_button "ログイン"
      expect(current_path).to eq root_path
      expect(page).to_not have_content "ログインしました。"
    end
  
    it "無効な情報の場合、ログインに失敗すること" do
      user = FactoryBot.create(:user, name: 'sample',
        email: 'sample_a@example.com',
        password: 'password')
      visit login_path
      fill_in "メールアドレス", with: ""
      fill_in "パスワード", with: ""
      click_button "ログイン"
      expect(current_path).to eq login_path
      expect(page).to have_content "ログイン"
      expect(page).to have_content "メールアドレスまたはパスワードが有効ではありません"
    end

    it " メールアドレスが有効化されていない場合 " do
      #emailはユニークにしないと登録できないから省略
      user = FactoryBot.create(:user,  :unactivated,
                                name: 'sample',
                                email: 'sample_b@example.com',
                                password: 'password')
      visit login_path
      fill_in "メールアドレス", with: "sample_b@example.com"
      fill_in "パスワード", with: 'password'
      click_button "ログイン"
      expect(current_path).to eq root_path
      expect(page).to have_content "アカウントが有効ではありません メールをご確認ください"
    end

end