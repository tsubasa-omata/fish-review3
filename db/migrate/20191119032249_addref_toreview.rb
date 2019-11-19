class AddrefToreview < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :reviews, :users, column: :user_id
    add_index :reviews, [:user_id, :created_at]
    add_index :reviews, [:fish_id,:season, :place]
  end
end
