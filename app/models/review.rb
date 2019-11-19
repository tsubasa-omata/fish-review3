class Review < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :taste_level
    validates :season
    validates :place
    validates :fish_size
  end
end
