require 'rails_helper'

RSpec.describe Review, type: :model do

  let(:review) { FactoryBot.create(:review) }

  context " 投稿が正しい場合 " do
    it " 正しい値が入っている場合 " do
      expect(review).to be_valid
    end
  end

  context " taste_impについて " do
    it " 200文字以上の場合無効か " do
      review.taste_imp = "a" * 201
      expect(review).to be_invalid
    end
  end

  context " placeについて " do
    it " 空欄の場合無効か " do
      review.place = " "
      expect(review).to be_invalid
    end
  end

  context " place_detailについて " do
    it " 空欄の場合有効か " do
      review.place_detail = " "
      expect(review).to be_valid
    end
    it " 11文字以上の場合無効か " do
      review.place_detail = "a" * 11
      expect(review).to be_invalid
    end
  end

  context " recipeについて " do
    it " 空欄の場合有効か " do
      review.recipe = " "
      expect(review).to be_valid
    end
    it " 11文字以上の場合無効か " do
      review.recipe = "a" * 11
      expect(review).to be_invalid
    end
  end

  context " seasonについて " do
    it " 空欄の場合無効か " do
      review.season = " "
      expect(review).to be_invalid
    end
    it " 13以上の場合無効か " do
      review.season = 13
      expect(review).to be_invalid
    end
  end

  context " taste_levelについて " do
    it " 空欄の場合無効か " do
      review.taste_level = " "
      expect(review).to be_invalid
    end
    it " 6以上の場合無効か " do
      review.taste_level = 6
      expect(review).to be_invalid
    end
  end

  context " fish_idについて " do
    it " fish_idがない場合無効か " do
      review.fish_id = " "
      expect(review).to be_invalid
    end
  end


end
