class ChangeDataRememberDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :remember_digest, :string
  end
end
