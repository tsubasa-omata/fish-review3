class RenameFishToFishes < ActiveRecord::Migration[5.2]
  def change
    rename_table :fish, :fishes
  end
end
