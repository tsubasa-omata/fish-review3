class ChangeDataPreservationPeriodToRevires < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :preservation_period, :integer
  end
end
