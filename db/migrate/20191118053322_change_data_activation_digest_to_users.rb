class ChangeDataActivationDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :activation_digest, :string
  end
end
