require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryBot.build(:user)
  end
  context " createアクション " do
    it " 登録時ユーザーが1人増えているか " do
      expect{ User.create(name: "aa", email: "aaa@gmail.com", account_name: "aaaaaaa", password: "aaaaaaa") }.to change{ User.count }.by(1)
    end
  end
end