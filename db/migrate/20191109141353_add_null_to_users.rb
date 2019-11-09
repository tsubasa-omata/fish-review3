class AddNullToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :account_name, false
  end
end
