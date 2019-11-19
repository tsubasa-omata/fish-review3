class AddDefaultToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :blood, :bloolean, default: false
  end
end
