class AddUsersInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_name,      :string
    add_column :users, :password_digest,   :integer
    add_column :users, :remember_digest,   :integer
    add_column :users, :activation_digest, :integer
    add_column :users, :activated,         :boolean, default: false
    add_column :users, :reset_digest,      :integer
    add_column :users, :reset_sent_at,     :datetime
    add_column :users, :picture,           :string
  end
end
