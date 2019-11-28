class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.bigint :user_id     , null: false
      t.integer :fish_id     , null: false
      t.integer :taste_level , null: false
      t.string  :season      , null: false
      t.string  :place       , null: false
      t.string  :place_detail
      t.string  :recipe
      t.string  :preservation_period
      t.integer :fish_size   , null: false
      t.boolean :blood       
      t.text    :taste_imp   
      t.string  :picture

      t.timestamps
    end
  end
end
