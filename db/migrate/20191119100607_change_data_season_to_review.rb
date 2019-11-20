class ChangeDataSeasonToReview < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :season, :integer
  end
end
