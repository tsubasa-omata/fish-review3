require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザーが正しい場合'
    it 'nameの値が入っている場合' do
　　　　expect(FactoryBot.build(:user)).to be_valid
    end
end
